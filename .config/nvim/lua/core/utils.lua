local M = {}

M.get_dir = function()
  local str = debug.getinfo(2, "S").source
  if str:sub(1, 1) == "@" then
    local filepath = str:sub(2)
    return vim.fn.fnamemodify(vim.uv.fs_realpath(filepath) or filepath, ":p:h")
  end
  return nil
end

M.find_files = function(path)
  local files = {}
  local handle = vim.uv.fs_scandir(path)

  if handle then
    while true do
      local name, type = vim.uv.fs_scandir_next(handle)
      if not name then break end
      if type == "file" then
        table.insert(files, name)
      end
    end
  end

  return files
end

return M
