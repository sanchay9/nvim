return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      local lualine_require = require "lualine_require"
      lualine_require.require = require

      local function fg(name)
        ---@type {foreground?:number}?
        local hl = vim.api.nvim_get_hl and vim.api.nvim_get_hl(0, { name = name })
          ---@diagnostic disable-next-line: deprecated
          or vim.api.nvim_get_hl_by_name(name, true)
        ---@diagnostic disable-next-line: undefined-field
        local fg = hl and (hl.fg or hl.foreground)
        return fg and { fg = string.format("#%06x", fg) } or nil
      end

      local custom = require "lualine.themes.auto"
      -- custom.normal.c.bg = fg("EndOfBuffer").fg
      custom.normal.c.bg = nil

      return {
        options = {
          theme = custom,
          component_separators = "",
          section_separators = { left = "", right = "" },
          globalstatus = true,
          disabled_filetypes = {
            statusline = { "alpha", "markdown" },
            winbar = { "markdown", "alpha", "man", "help", "NvimTree" },
          },
        },
        sections = {
          lualine_a = {
            { "mode", separator = { left = " █", right = "█" }, padding = { left = 0, right = 0 } },
          },
          lualine_b = {
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            { "filename", path = 1, separator = "", padding = { left = 0, right = 1 } },
            "branch",
          },
          lualine_c = {
            { "diagnostics" },
            {
              require("noice").api.status.mode.get,
              cond = require("noice").api.status.mode.has,
              color = "DiagnosticWarn",
            },
          },
          lualine_x = {
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = "DiagnosticError",
            },
            { "diff" },
          },
          lualine_y = {
            { "progress", separator = " ", padding = { left = 1, right = 1 } },
          },
          lualine_z = {
            { "location", separator = { right = "█ " }, padding = { left = 0, right = 0 } },
          },
        },
        extensions = {
          "lazy",
          "mason",
          "man",
          "trouble",
          "oil",
          "nvim-dap-ui",
          "quickfix",
          "symbols-outline",
          "fugitive",
        },
      }
    end,
  },
}
