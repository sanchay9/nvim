return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      local lualine_require = require "lualine_require"
      lualine_require.require = require

      local function color(name)
        local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
        local colorbg = nil
        local colorfg = nil
        if hl then
          colorbg = hl.bg or hl.background
          colorfg = hl.fg or hl.foreground
        end
        colorbg = colorbg and string.format("#%06x", colorbg) or nil
        colorfg = colorfg and string.format("#%06x", colorfg) or nil
        return { bg = colorbg, fg = colorfg }
      end

      local custom = require "lualine.themes.auto"
      -- custom.normal.c.bg = fg("EndOfBuffer").fg
      custom.normal.c.bg = nil

      local default_sep_icons = {
        default = { "", "" },
        round = { "", "" },
        block = { "█", "█" },
        arrow = { "", "" },
      }

      local separators = default_sep_icons["round"]

      local space = {
        function()
          return " "
        end,
        color = { bg = color("Normal").bg },
        padding = { left = 0, right = 0 },
      }

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
            space,
            {
              "mode",
              color = { gui = "bold" },
              separator = { left = separators[1], right = separators[2] },
              padding = { left = 0, right = 0 },
            },
          },
          lualine_b = {
            {
              "filetype",
              icon_only = true,
              separator = "",
              padding = { left = 1, right = 0 },
            },
            {
              "filename",
              path = 1,
              separator = { left = "", right = separators[2] },
              padding = { left = 0, right = 0 },
            },
            space,
            "kulala",
            "require'lsp-status'.status()",
            {
              "branch",
              icon = "",
              separator = { left = separators[1], right = separators[2] },
              padding = { left = 0, right = 0 },
            },
            {
              "diff",
              separator = { left = separators[1], right = separators[2] },
              symbols = { added = " ", modified = " ", removed = " " },
              padding = { left = 1, right = 0 },
            },
          },
          lualine_c = {
            -- stylua: ignore
            {
              function() return require("noice").api.status.mode.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
              color = "Constant",
            },
            {
              function()
                return "  " .. require("dap").status()
              end,
              cond = function()
                return package.loaded["dap"] and require("dap").status() ~= ""
              end,
              color = "Debug",
            },
          },
          lualine_x = {
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = "Special",
            },
            { "diagnostics" },
          },
          lualine_y = {},
          lualine_z = {
            {
              "location",
              color = { gui = "bold" },
              separator = { left = separators[1], right = separators[2] },
              padding = { left = 0, right = 0 },
            },
            space,
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
