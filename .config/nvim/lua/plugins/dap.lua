return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      local keymaps = {
        { "<F5>",      function() dap.continue() end,          "DAP continue/start" },
        { "<leader>b", function() dap.toggle_breakpoint() end, "DAP toggle breakpoint" },
        { "<DOWN>",    function() dap.step_over() end,         "DAP step over" },
        { "<RIGHT>",   function() dap.step_into() end,         "DAP step into" },
        { "<LEFT>",    function() dap.step_out() end,          "DAP step out" },
        { "<UP>",      function() dap.restart_frame() end,     "DAP restart frame" },
      }
      for _, keymap in pairs(keymaps) do
        vim.keymap.set("n", keymap[1], keymap[2], { desc = keymap[3] })
      end
    end
  },
  {
    "igorlfs/nvim-dap-view",
    opts = {},
    setup = function()
      vim.keymap.set("n", "<leader>dv", "<cmd>DapViewToggle<cr>", { desc = "DAP View Toggle" })
    end
  },
  { "theHamsta/nvim-dap-virtual-text", opts = {} }
}
