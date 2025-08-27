local M = {}

local c = require "statuslinee.components"
local ut = require "utils"
local z = require "statuslinee.custom"
local colors = c.colors

local normal_hl = vim.api.nvim_get_hl(0, { name = "Normal" })
local statusline_hl = vim.api.nvim_get_hl(0, { name = "StatusLine" })
local fg_lighten = normal_hl.bg and ut.darken(string.format("#%06x", normal_hl.bg), 0.6) or colors.stealth

-- Create highlight groups
vim.api.nvim_set_hl(0, "SLBgNoneHl", { fg = colors.fg_hl, bg = "none" })
vim.api.nvim_set_hl(0, "StatusReplace", { bg = colors.red, fg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "StatusInsert", { bg = colors.insert, fg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "StatusVisual", { bg = colors.select, fg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "StatusNormal", { bg = colors.blue, fg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "StatusCommand", { bg = colors.yellow, fg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "StatusReplaceInv", { fg = colors.red, bg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "StatusInsertInv", { fg = colors.insert, bg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "StatusVisualInv", { fg = colors.select, bg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "StatusNormalInv", { fg = colors.blue, bg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "StatusCommand", { fg = colors.yellow, bg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "SLNotModifiable", { fg = colors.yellow, bg = statusline_hl.bg })
vim.api.nvim_set_hl(0, "SLNormal", { fg = fg_lighten, bg = statusline_hl.bg })
vim.api.nvim_set_hl(0, "SLModified", { fg = "#FF7EB6", bg = statusline_hl.bg })
vim.api.nvim_set_hl(0, "SLMatches", { fg = colors.bg_hl, bg = colors.fg_hl })
vim.api.nvim_set_hl(0, "SLDecoratorColor", { fg = "#414868", bg = "#7AA2F7", bold = true })
vim.api.nvim_set_hl(0, "SLDecorator", { fg = "#414868", bg = "none", bold = true })
vim.api.nvim_set_hl(0, "SLCustom", { fg = colors.blue, bg = "none", bold = true })
vim.api.nvim_set_hl(0, "Statusline", { fg = "none", bg = "none" })

---@return string
function M.render()
  local custom_statusline_funcs = {
    ["snacks_terminal"] = z.Snacks_Terminal_SL,
    ["NeogitStatus"] = z.NeogitStatus_SL,
    ["oil"] = z.Oil_SL,
    ["fzf"] = z.Fzf_SL,
    ["image"] = z.Image_SL,
    ["lazy"] = z.Lazy_SL,
    ["http"] = z.Kulala_SL,
  }

  local func = custom_statusline_funcs[vim.bo.filetype]
  if func then
    return func()
  end

  local components = {
    -- "%#SLNormal#",
    c.padding(),
    -- c.mode(),
    c.fileinfo { add_icon = true },

    "%=",

    c.maximized_status(),
    c.search_count(),
    c.show_macro_recording(),

    "%=",

    _G.show_more_info and c.lang_version() or "",
    _G.show_more_info and c.LSP() or "",
    _G.show_more_info and " Ux%04B " or "",
    c.is_terminal_open(),
    _G.show_more_info and c.git_branch() or "",
    _G.show_more_info and c.separator() or "",
    c.lsp_diagnostics_simple(),
    c.padding(),
    c.git_status_simple(),
    c.padding(),
    c.get_fileinfo_widget(),
    -- c.get_position(),
    -- c.file_icon() .. " ",
    c.padding(),
    c.scrollbar(),
    -- c.padding(3),
  }

  return table.concat(components)
end

vim.o.statusline = "%!v:lua.require'statuslinee.statuslinee'.render()"

-- TODO: https://www.reddit.com/r/neovim/comments/1kuiywf/show_off_your_statusline_here/
-- https://github.com/rachartier/dotfiles/blob/main/.config/nvim/lua/plugins/ui/lualine.lua

return M
