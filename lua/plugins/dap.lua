---@param config {args?:string[]|fun():string[]?}
local function get_args(config)
  local args = type(config.args) == "function" and (config.args() or {}) or config.args or {}
  config = vim.deepcopy(config)
  ---@cast args string[]
  config.args = function()
    local new_args = vim.fn.input("Run with args: ", table.concat(args, " ")) --[[@as string]]
    return vim.split(vim.fn.expand(new_args) --[[@as string]], " ")
  end
  return config
end

return {
  "mfussenegger/nvim-dap",
  -- stylua: ignore
  keys = {
    { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
    { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
    { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
    { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
    { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
    { "<leader>dj", function() require("dap").down() end, desc = "Down" },
    { "<leader>dk", function() require("dap").up() end, desc = "Up" },
    { "<leader>dO", function() require("dap").step_out() end, desc = "Step Out" },
    { "<leader>do", function() require("dap").step_over() end, desc = "Step Over" },
    { "<leader>dt", function() require("dap").repl.toggle({wrap=true,nu=false}, "botright split") end, desc = "Toggle REPL" },
    { "<leader>dq", function() require("dap").terminate() end, desc = "Terminate" },
    { "<leader>de", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
    { "<Leader>df", function() local widgets = require('dap.ui.widgets') widgets.centered_float(widgets.frames) end },
    { "<Leader>dp", function() local widgets = require('dap.ui.widgets') widgets.centered_float(widgets.scopes) end },
  },
  dependencies = {
    {
      "theHamsta/nvim-dap-virtual-text",
      opts = {},
    },
    {
      "leoluz/nvim-dap-go",
      opts = {},
    },
  },
  config = function()
    local dap = require "dap"

    dap.adapters.codelldb = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = "codelldb",
        args = {
          "--port",
          "${port}",
        },
      },
    }

    dap.configurations.cpp = {
      {
        type = "codelldb",
        request = "launch",
        name = "Launch file",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
      },
    }

    local icons = require("icons").dap
    vim.api.nvim_set_hl(0, "DapStoppedLine", { default = false, link = "Visual" })
    for name, sign in pairs(icons) do
      sign = type(sign) == "table" and sign or { sign }
      vim.fn.sign_define(
        "Dap" .. name,
        { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
      )
    end
  end,
}
