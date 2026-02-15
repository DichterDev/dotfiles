local M = {}

local data = vim.fn.stdpath("data")
local cache = vim.fn.stdpath("cache")
local mason = data .. "/mason"

---@return table<string>
M.get_root_markers = function()
  return {
    "build.xml",
    "mvnw",
    "pom.xml",
    "gradlew",
    "settings.gradle",
    "settings.gradle.kts",
    "build.gradle",
    "build.gradle.kts",
  }
end

---@param root_markers table<string>
---@return string
M.get_root_dir = function(root_markers)
  return vim.fs.root(0, root_markers) or vim.fn.getcwd()
end


---@param root_dir string
---@return string
M.get_workspace_dir = function(root_dir)
  local root_hash = vim.fn.sha256(root_dir):sub(1, 8)

  local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
  local workspace_dir = cache .. "/jdtls/workspace/" .. project_name .. "-" .. root_hash

  if vim.fn.isdirectory(workspace_dir) == 0 then
    vim.fn.mkdir(workspace_dir, "p")
    vim.notify("Created Workspace Directory: " .. workspace_dir, vim.log.levels.INFO)
  else
    vim.notify("Workspace: " .. workspace_dir, vim.log.levels.INFO)
  end

  return workspace_dir
end

---@return string
M.get_lombok = function()
  return vim.fn.glob(mason .. "/share/jdtls/lombok.jar", true)
end

---@return table<string>
M.get_spring_boot_extensions = function()
  return vim.fn.glob(mason .. "/share/vscode-spring-boot-tools/jdtls/*.jar", true, true)
end

---@param root_dir string
---@return "unknown" | "quarkus" | "spring"
M.detect_framework = function(root_dir)
  local build_files = { "pom.xml", "build.gradle", "build.gradle.kts" }

  for _, file in ipairs(build_files) do
    file = root_dir .. "/" .. file
    vim.notify(file)
    if vim.fn.filereadable(file) == 1 then
      local content = table.concat(vim.fn.readfile(file), " ")

      if content:find("quarkus") then
        return "quarkus"
      elseif content:find("spring%-boot") or content:find("springframework") then
        return "spring"
      end
    end
  end
  return "unknown"
end

return M
