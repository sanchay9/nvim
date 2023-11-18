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

      local function get_clients(opts)
        local ret = {} ---@type lsp.Client[]
        if vim.lsp.get_clients then
          ret = vim.lsp.get_clients(opts)
        else
          ---@diagnostic disable-next-line: deprecated
          ret = vim.lsp.get_active_clients(opts)
          if opts and opts.method then
            ---@param client lsp.Client
            ret = vim.tbl_filter(function(client)
              return client.supports_method(opts.method, { bufnr = opts.bufnr })
            end, ret)
          end
        end
        return opts and opts.filter and vim.tbl_filter(opts.filter, ret) or ret
      end

      -- local custom = require "lualine.themes.auto"
      -- custom.normal.c.bg = fg("EndOfBuffer").fg

      return {
        options = {
          theme = "auto",
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
            { "mode", separator = { left = " " }, padding = { left = 0, right = 0 } },
          },
          lualine_b = {
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            { "filename", path = 1 },
            "branch",
          },
          lualine_c = {
            { "diagnostics" },
            {
              require("noice").api.statusline.mode.get,
              cond = require("noice").api.statusline.mode.has,
              color = "DiagnosticWarn",
            },
          },
          lualine_x = {
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = "DiagnosticError",
            },
            {
              function()
                local status = require("copilot.api").status.data
                return " " .. (status.message or "")
              end,
              cond = function()
                if not package.loaded["copilot"] then
                  return
                end
                local ok, clients = pcall(get_clients, { name = "copilot", bufnr = 0 })
                if not ok then
                  return false
                end
                return ok and #clients > 0
              end,
              color = function()
                if not package.loaded["copilot"] then
                  return
                end
                local colors = {
                  [""] = fg "Special",
                  ["Normal"] = fg "Special",
                  ["Warning"] = fg "DiagnosticError",
                  ["InProgress"] = fg "DiagnosticWarn",
                }
                local status = require("copilot.api").status.data
                return colors[status.status] or colors[""]
              end,
            },
            { "diff" },
          },
          lualine_y = {
            { "progress", separator = " ", padding = { left = 0, right = 1 } },
          },
          lualine_z = {
            { "location", separator = { right = " " }, padding = { left = 0, right = 0 } },
          },
        },
        winbar = {
          -- lualine_a = {},
          -- lualine_b = {},
          -- lualine_c = {
          --   {
          --     "filename",
          --     file_status = false,
          --   },
          --   {
          --     function()
          --       return require("nvim-navic").get_location()
          --     end,
          --     cond = function()
          --       return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
          --     end,
          --   },
          -- },
          -- lualine_x = {},
          -- lualine_y = {},
          -- lualine_z = {},
        },
        extensions = { "lazy", "mason", "nvim-tree", "man", "trouble" },
      }
    end,
  },
}
