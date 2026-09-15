local M = {}

---@class core.pack.spec.Config : vim.pack.Spec

---@alias core.pack.Spec core.pack.spec.Config | string

---@class core.pack.pkg.Config
---@field tag? string
---@field spec core.pack.Spec
---@field deps? core.pack.Spec[]

---@alias core.pack.Package core.pack.pkg.Config | string

---@class core.pack.InternalEntry
---@field tag? string
---@field spec core.pack.Spec
---@field deps? core.pack.Spec[]

---@type table<string, core.pack.InternalEntry[]>
M.pkgs = {}

---Format string: length <= 4 -> all upper; length > 4 -> first upper, rest same
---@param str string
---@return string
local function format_heading(str)
	if not str or #str == 0 then
		return ""
	end
	if #str <= 4 then
		return str:upper()
	end
	return str:sub(1, 1):upper() .. str:sub(2)
end

---Extract URL / Repo string and display name from any spec type
---@param spec core.pack.Spec
---@return string url, string display_name
local function parse_spec(spec)
	local url = type(spec) == "table" and (spec.src or spec[1]) or spec
	local name = url:match("([^/]+/[^/]+)%.git$") or url:match("([^/]+/[^/]+)$") or url
	return url, name
end

---Add packages to Neovim pack environment and record them into categories
---@param category string
---@param pkgs table<number|string, any>
---@param opts? vim.pack.keyset.add
function M.add(category, pkgs, opts)
	opts = opts or {}
	M.pkgs[category] = M.pkgs[category] or {}

	local specs_to_add = {}

	local function process_entry(entry, tag_override)
		local is_table = type(entry) == "table"
		local is_config = is_table and (entry.spec ~= nil)

		local spec = is_config and entry.spec or entry
		local deps = is_config and entry.deps or nil
		local tag = tag_override or (is_config and entry.tag or nil)

		-- Collect dependencies
		if deps then
			for _, dep in ipairs(deps) do
				table.insert(specs_to_add, dep)
			end
		end

		-- Collect target plugin
		table.insert(specs_to_add, spec)

		-- Track entry
		table.insert(M.pkgs[category], {
			tag = tag,
			spec = spec,
			deps = deps,
		})
	end

	-- Process array elements (untagged) and string keys (tags)
	for k, v in pairs(pkgs) do
		if type(k) == "string" then
			if type(v) == "table" and not v.spec then
				for _, nested in ipairs(v) do
					process_entry(nested, k)
				end
			else
				process_entry(v, k)
			end
		else
			process_entry(v, nil)
		end
	end

	-- Batch load all collected specs at once
	if #specs_to_add > 0 then
		vim.pack.add(specs_to_add, opts)
	end
end

---Render markdown documentation into README.md located in the Neovim config directory
function M.gen_readme()
	local readme_path = vim.fn.stdpath("config") .. "/README.md"
	local start_marker = "<!-- PACK_CATEGORIES:START -->"
	local end_marker = "<!-- PACK_CATEGORIES:END -->"

	local lines = {}
	table.insert(lines, start_marker)

	-- Sort categories alphabetically
	local sorted_categories = {}
	for cat in pairs(M.pkgs) do
		table.insert(sorted_categories, cat)
	end
	table.sort(sorted_categories)

	for _, raw_category in ipairs(sorted_categories) do
		local entries = M.pkgs[raw_category]
		table.insert(lines, "")
		table.insert(lines, string.format("## %s", format_heading(raw_category)))

		local untagged = {}
		local tagged_groups = {}
		local sorted_tags = {}

		for _, item in ipairs(entries) do
			if item.tag and item.tag ~= "" then
				if not tagged_groups[item.tag] then
					tagged_groups[item.tag] = {}
					table.insert(sorted_tags, item.tag)
				end
				table.insert(tagged_groups[item.tag], item)
			else
				table.insert(untagged, item)
			end
		end

		local function render_item(item)
			local url, name = parse_spec(item.spec)
			-- Main plugin bullet point
			table.insert(lines, string.format("- [%s](%s)", name, url))

			-- Nested dependency bullet points
			if item.deps and #item.deps > 0 then
				for _, dep in ipairs(item.deps) do
					local dep_url, dep_name = parse_spec(dep)
					table.insert(lines, string.format("    - [%s](%s)", dep_name, dep_url))
				end
			end
		end

		-- 1. Untagged plugins directly under ## Category
		for _, item in ipairs(untagged) do
			render_item(item)
		end

		-- 2. Tagged groups under ### Tag
		table.sort(sorted_tags)
		for _, raw_tag in ipairs(sorted_tags) do
			table.insert(lines, "")
			table.insert(lines, string.format("### %s", format_heading(raw_tag)))

			for _, item in ipairs(tagged_groups[raw_tag]) do
				render_item(item)
			end
		end
	end

	table.insert(lines, "")
	table.insert(lines, end_marker)
	local generated_block = table.concat(lines, "\n")

	-- Read existing README
	local content = ""
	local f_read = io.open(readme_path, "r")
	if f_read then
		content = f_read:read("*a")
		f_read:close()
	end

	-- Replace or append block
	local final_content
	local pattern = "(.-)" .. vim.pesc(start_marker) .. ".-" .. vim.pesc(end_marker) .. "(.*)"
	local before, after = content:match(pattern)

	if before and after then
		final_content = before .. generated_block .. after
	else
		local cleaned = content
		for _, cat in ipairs(sorted_categories) do
			local header_pattern = "\n?##%s+" .. vim.pesc(format_heading(cat)) .. ".-(?=\n##%s|\n?<!--|$)"
			cleaned = cleaned:gsub(header_pattern, "")
		end
		cleaned = vim.trim(cleaned)
		final_content = (#cleaned > 0 and (cleaned .. "\n\n") or "") .. generated_block .. "\n"
	end

	local f_write = io.open(readme_path, "w")
	if not f_write then
		vim.notify(string.format("Failed to open %s for writing", readme_path), vim.log.levels.ERROR)
		return
	end

	f_write:write(final_content)
	f_write:close()
	vim.notify(string.format("Updated %s successfully", readme_path), vim.log.levels.INFO)
end

return M
