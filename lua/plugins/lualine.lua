return {
  {
    "nvim-lualine/lualine.nvim",
    enabled = false,
    event = "VeryLazy",
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        -- set an empty statusline till lualine loads
        vim.o.statusline = " "
      else
        -- hide the statusline on the starter page
        vim.o.laststatus = 0
      end
    end,
    opts = function()
      local lualine_require = require "lualine_require"
      lualine_require.require = require

      local icons = require "icons"

      vim.o.laststatus = vim.g.lualine_laststatus

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
      custom.normal.c.bg = color("Normal").bg

      local separators = require("icons").sep["round"]

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
          globalstatus = vim.o.laststatus == 3,
          disabled_filetypes = {
            statusline = { "alpha", "markdown", "snacks_dashboard" },
            winbar = { "markdown", "alpha", "man", "help", "NvimTree" },
          },
        },
        sections = {
          lualine_a = {
            space,
            {
              "mode",
              fmt = function(str)
                return str:sub(1, 3)
              end,
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
            Snacks.profiler.status(),
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
              symbols = {
                added = icons.git.added,
                modified = icons.git.modified,
                removed = icons.git.removed,
              },
              source = function()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                  return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                  }
                end
              end,
              padding = { left = 1, right = 0 },
            },
          },
          lualine_c = {
            {
              function()
                return icons.misc.DapStatusLine .. require("dap").status()
              end,
              cond = function()
                return package.loaded["dap"] and require("dap").status() ~= ""
              end,
              color = "Debug",
            },
            -- stylua: ignore
            {
              require("noice").api.status.mode.get,
              cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
              color = function() return { fg = Snacks.util.color "Constant" } end,
            },
            -- stylua: ignore
            {
              require("noice").api.status.search.get,
              cond = function() return package.loaded["noice"] and require("noice").api.status.search.has() end,
              color = function() return { fg = Snacks.util.color "Statement" } end,
            },
          },
          lualine_x = {
            {
              "diagnostics",
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
            },
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
          "fzf",
          "mason",
          "man",
          "trouble",
          "oil",
          "nvim-dap-ui",
          "quickfix",
          "symbols-outline",
        },
      }
    end,
  },
}
