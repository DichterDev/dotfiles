local jdtls = require("jdtls")
local spring = require("spring_boot")
local quarkus = require("quarkus")
local microprofile = require("microprofile")

local config = require("lsp.servers.jdtls").config or {}
local utils = require("core.utils")

local root_markers = utils.java.get_root_markers()
local root_dir = utils.java.get_root_dir(root_markers)
local framework = utils.java.detect_framework(root_dir)

local bundles = config.init_options.bundles

if (framework == "spring") then
  vim.list_extend(bundles, utils.java.get_spring_boot_extensions())
elseif (framework == "quarkus") then
  vim.list_extend(bundles, quarkus.java_extensions())
  vim.list_extend(bundles, microprofile.java_extensions())
end

config.cmd = {
  "jdtls",
  "-data",
  utils.java.get_workspace_dir(root_dir),
  "--jvm-arg=-javaagent:" .. utils.java.get_lombok(),
  "--jvm-arg=-Xmx2g"
}

config.on_init = function(_, _)
  if (framework == "spring") then
  elseif (framework == "quarkus") then
    require("quarkus.bind").try_bind_qute_all_request()
    require("microprofile.bind").try_bind_microprofile_all_request()
  end
end

config.init_options.bundles = bundles

jdtls.start_or_attach(config)


if (framework == "spring") then
  -- require("spring_boot.launch").start(require("lsp.servers.spring-boot").config)
elseif (framework == "quarkus") then
  vim.lsp.start(require("lsp.servers.quarkus").config)
  vim.lsp.start(require("lsp.servers.microprofile").config)
end
