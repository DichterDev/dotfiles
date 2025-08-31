local plugins = {
  require("plugins.color"),
  require("plugins.mini"),
  require("plugins.picker"),
  require("plugins.treesitter"),
  require("plugins.lazydev"),
  require("plugins.blink"),
  require("plugins.mason"),
  require("plugins.mason-tool-installer"),
  require("plugins.lsp"),
}

-- adds all plugins
for _, plugin in ipairs(plugins) do
  MiniDeps.add(plugin.add)
end

-- add all dependencies
for _, plugin in ipairs(plugins) do
  if(plugin.add.depends) then
    for _, src in ipairs(plugin.add.depends) do
      MiniDeps.add({ source = src })
    end
  end
end

-- executes setup
for _, plugin in ipairs(plugins) do
  plugin.setup()
end
