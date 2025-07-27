local c = require "statuslinee.components"
local utils = require "utils"
local hl_str = utils.hl_str

local M = {}

---Get a status decorator for some filetypes
---@return string
---@param opts? {name:string, align:string}
function M.decorator(opts)
  opts = vim.tbl_extend("force", { name = " ", align = "left" }, opts)
  local align = vim.tbl_contains({ "left", "right" }, opts.align) and opts.align or "left"
  local name = " " .. opts.name .. " "
  return (align == "right" and "%=" or "") .. hl_str("SLDecoratorColor", name)
end

function M.Snacks_Terminal_SL()
  return c.padding() .. c.file_icon { mono = false } .. " Terminal"
end

function M.NeogitStatus_SL()
  return c.padding() .. c.file_icon { mono = false } .. " Neogit"
end

function M.Oil_SL()
  -- local home_dir = os.getenv "HOME"
  -- local dir = require("oil").get_current_dir(vim.api.nvim_get_current_buf())
  -- dir = dir and dir:gsub("^" .. home_dir, "~")

  local dir = vim.fn.fnamemodify(require("oil").get_current_dir(), ":~")
  return hl_str("SLCustom", "  oil: ") .. dir
end

function M.Fzf_SL()
  local ok, fzf = pcall(require, "fzf-lua")

  if not ok then
    return ""
  end

  local info_string = vim.inspect(fzf.get_info()["fnc"])
  local picker = info_string:gsub('"', "")

  -- TODO: element
  -- local selected = fzf.get_info().selected
  -- local element = fzf.path.entry_to_file(selected).path

  return c.padding()
    .. M.decorator {
      name = "fzf",
      align = "left",
    }
    .. M.decorator {
      name = picker,
      align = "right",
    }
end

function M.Image_SL()
  local file = vim.fn.expand "%:t"
  local file_icon = c.file_icon { mono = false }
  return c.padding() .. file_icon .. " " .. file
end

function M.Lazy_SL()
  local ok, lazy = pcall(require, "lazy")
  if not ok then
    return ""
  end

  return c.padding()
    .. M.decorator {
      name = " lazy 💤 ",
      align = "left",
    }
    .. M.decorator {
      name = "loaded: " .. lazy.stats().loaded .. "/" .. lazy.stats().count,
      align = "right",
    }
end

function M.Kulala_SL()
  local CONFIG = require "kulala.config"
  local env = vim.g.kulala_selected_env or CONFIG.get().default_env
  return c.fileinfo { add_icon = true } .. hl_str("SLCustom", "    ") .. env
end

-- TODO: https://github.com/nvim-lualine/lualine.nvim/blob/master/lua/lualine/extensions

return M
