local utils = require("core.utils")

local root_markers = utils.java.get_root_markers()
local root_dir = utils.java.get_root_dir(root_markers)
local framework = utils.java.detect_framework(root_dir)

if (framework == "spring") then
  vim.lsp.start(require("lsp.servers.spring-boot").config)
elseif (framework == "quarkus") then
  vim.lsp.start(require("lsp.servers.quarkus").config)
  vim.lsp.start(require("lsp.servers.microprofile").config)
end
