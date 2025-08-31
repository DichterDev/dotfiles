local add = { source = "mason-org/mason.nvim", cmd = "Mason" }

local setup = function()
  require("mason").setup({
    ui = {
      icons = {
        package_installed = '✓',
        package_pending = '➜',
        package_uninstalled = '✗',
      },
      check_outdated_packages_on_open = true,
      border = 'rounded',
      width = 0.9,
      height = 0.9,
    }
  })
end

return { add = add, setup = setup }
