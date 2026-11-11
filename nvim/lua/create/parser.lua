local M = {}

--- Applies case transformations to a string
--- @param str string
--- @param casing string "pascal"|"camel"|"snake"|"kebab"|"upper"|"lower"
--- @return string
local function apply_case(str, casing)
	if not casing or casing == "" then
		return str
	end

	if casing == "pascal" then
		return (
			str:gsub("(%a)([%w_]*)", function(first, rest)
				return first:upper() .. rest:lower()
			end):gsub("[%-_%s]", "")
		)
	elseif casing == "camel" then
		local pascal = apply_case(str, "pascal")
		return pascal:sub(1, 1):lower() .. pascal:sub(2)
	elseif casing == "snake" then
		return (
			str:gsub("(%f[%w]%w)", function(c)
				return c
			end)
				:gsub("(%a)(%d)", "%1_%2")
				:gsub("(%d)(%a)", "%1_%2")
				:gsub("(%l)(%u)", "%1_%2")
				:gsub("[%-%s]+", "_")
				:lower()
		)
	elseif casing == "kebab" then
		return (apply_case(str, "snake"):gsub("_", "-"))
	elseif casing == "upper" then
		return str:upper()
	elseif casing == "lower" then
		return str:lower()
	end

	return str
end

--- Expands brace groups `{a, b}` into an array of string possibilities
--- @param text string
--- @return string[]
local function expand_braces(text)
	local open_idx = text:find("{")
	if not open_idx then
		return { text }
	end

	local close_idx = nil
	local depth = 0
	for i = open_idx, #text do
		local char = text:sub(i, i)
		if char == "{" then
			depth = depth + 1
		elseif char == "}" then
			depth = depth - 1
			if depth == 0 then
				close_idx = i
				break
			end
		end
	end

	if not close_idx then
		return { text }
	end

	local prefix = text:sub(1, open_idx - 1)
	local suffix = text:sub(close_idx + 1)
	local body = text:sub(open_idx + 1, close_idx - 1)

	local alternatives = {}
	local current = ""
	depth = 0
	for i = 1, #body do
		local c = body:sub(i, i)
		if c == "{" then
			depth = depth + 1
			current = current .. c
		elseif c == "}" then
			depth = depth - 1
			current = current .. c
		elseif c == "," and depth == 0 then
			table.insert(alternatives, current:match("^%s*(.-)%s*$"))
			current = ""
		else
			current = current .. c
		end
	end
	table.insert(alternatives, current:match("^%s*(.-)%s*$"))

	local results = {}
	for _, alt in ipairs(alternatives) do
		local expanded_alts = expand_braces(prefix .. alt .. suffix)
		for _, item in ipairs(expanded_alts) do
			table.insert(results, item)
		end
	end

	return results
end

--- Expands range expressions (`stem[start]..[=]end[,step].ext`)
--- @param segment string
--- @return string[]
local function expand_range(segment)
	local prefix, start_str, op, end_str, step_str, ext = segment:match("^(.-)(%d*)(%.%.=?)(%d+),?(%d*)(%..*)$")

	if not op then
		prefix, start_str, op, end_str, step_str, ext = segment:match("^(.-)(%d*)(%.%.=?)(%d+),?(%d*)$")
		ext = ext or ""
	end

	if not op then
		return { segment }
	end

	local delim = "_"
	if prefix:sub(-1):match("[%w_]") then
		delim = "_"
	elseif prefix == "" or prefix:sub(-1) == "/" then
		delim = ""
	end

	local start_val = tonumber(start_str) or 0
	local end_val = tonumber(end_str)
	local is_inclusive = (op == "..=")
	local step = tonumber(step_str) or 1
	if step <= 0 then
		step = 1
	end

	local pad_width = #end_str
	if #start_str > pad_width then
		pad_width = #start_str
	end
	local fmt = string.format("%%0%dd", pad_width)

	local results = {}
	local curr = start_val
	local limit = is_inclusive and end_val or (end_val - 1)

	while curr <= limit do
		local num_formatted = string.format(fmt, curr)
		local expanded = prefix .. delim .. num_formatted .. ext
		table.insert(results, expanded)
		curr = curr + step
	end

	return results
end

--- Evaluates positional parent variables ($1, $2) and casing modifiers (:pascal, etc.)
--- @param path_segments string[]
--- @return string, string|nil
local function resolve_path_variables(path_segments)
	local resolved_segments = {}
	local template_modules = {}

	for idx, raw_seg in ipairs(path_segments) do
		local seg = raw_seg

		local clean_seg, mods = seg:match("^([^:]+)(.*)$")
		clean_seg = clean_seg or seg
		mods = mods or ""

		local case_mod = mods:match(":(pascal|camel|snake|kebab|upper|lower)")
		local template_mod = mods:match(":([%w_]+)")
		if case_mod and template_mod == case_mod then
			local case_pos = mods:find(":" .. case_mod) or 0
			template_mod = mods:match(":(%w+)", case_pos + #case_mod + 1)
		end

		if template_mod then
			table.insert(template_modules, template_mod)
		end

		clean_seg = clean_seg:gsub("%$(%d+)", function(var_idx)
			local level = tonumber(var_idx)
			local target_parent = resolved_segments[level] or ""
			if case_mod then
				return apply_case(target_parent, case_mod)
			end
			return target_parent
		end)

		if case_mod and not raw_seg:find("%$%d+") then
			local base_name, ext = clean_seg:match("^(.-)(%.%w+)$")
			if base_name then
				clean_seg = apply_case(base_name, case_mod) .. ext
			else
				clean_seg = apply_case(clean_seg, case_mod)
			end
		end

		table.insert(resolved_segments, clean_seg)
	end

	local full_path = table.concat(resolved_segments, "/")
	local module_spec = #template_modules > 0 and table.concat(template_modules, ":") or nil

	return full_path, module_spec
end

--- Main parsing entry point
--- @param input string
--- @return table[] Array of { path = string, template = string|nil }
function M.parse(input)
	local brace_expanded = expand_braces(input)
	local final_results = {}

	for _, expr in ipairs(brace_expanded) do
		local raw_segments = {}
		for seg in expr:gmatch("[^/]+") do
			table.insert(raw_segments, seg)
		end

		local segment_combos = { {} }
		for _, seg in ipairs(raw_segments) do
			local seg_expansions = expand_range(seg)
			local next_combos = {}
			for _, existing in ipairs(segment_combos) do
				for _, expanded_item in ipairs(seg_expansions) do
					local new_combo = { unpack(existing) }
					table.insert(new_combo, expanded_item)
					table.insert(next_combos, new_combo)
				end
			end
			segment_combos = next_combos
		end

		for _, combo in ipairs(segment_combos) do
			local path, template = resolve_path_variables(combo)
			table.insert(final_results, {
				path = path,
				template = template,
			})
		end
	end

	return final_results
end

return M
