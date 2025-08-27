local M = {}

M.bg = "#000000"
M.fg = "#ffffff"

---@param c string
local function hexToRgb(c)
  c = string.lower(c)
  return { tonumber(c:sub(2, 3), 16), tonumber(c:sub(4, 5), 16), tonumber(c:sub(6, 7), 16) }
end

---@param foreground string foreground color
---@param background string background color
---@param alpha number|string number between 0 and 1. 0 results in bg, 1 results in fg
local function blend(foreground, background, alpha)
  alpha = type(alpha) == "string" and (tonumber(alpha, 16) / 0xff) or alpha
  local bg = hexToRgb(background)
  local fg = hexToRgb(foreground)

  local blendChannel = function(i)
    local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
    return math.floor(math.min(math.max(0, ret), 255) + 0.5)
  end

  return string.format("#%02x%02x%02x", blendChannel(1), blendChannel(2), blendChannel(3))
end

function M.darken(hex, amount, bg)
  if vim.o.background == "dark" then
    -- if the background is dark, lighten instead
    return blend(hex, bg or M.fg, amount)
  end
  return blend(hex, bg or M.bg, amount)
end

function M.lighten(hex, amount, fg)
  if vim.o.background == "light" then
    -- if the background is light, darken instead
    return blend(hex, fg or M.bg, amount)
  end
  return blend(hex, fg or M.fg, amount)
end

local function get_cwd()
  local function realpath(path)
    if path == "" or path == nil then
      return nil
    end
    return vim.loop.fs_realpath(path) or path
  end

  return realpath(vim.loop.cwd()) or ""
end

---@return fun():string
function M.pretty_dirpath()
  return function()
    local path = vim.fn.expand "%:p" --[[@as string]]

    if path == "" then
      return ""
    end
    local cwd = get_cwd()

    if path:find(cwd, 1, true) == 1 then
      path = path:sub(#cwd + 2)
    end

    local sep = package.config:sub(1, 1)
    local parts = vim.split(path, "[\\/]")
    table.remove(parts)
    if #parts > 3 then
      parts = { parts[1], "…", parts[#parts - 1], parts[#parts] }
    end

    return #parts > 0 and (table.concat(parts, sep)) or ""
  end
end

function M.hl_str(hl, str)
  return "%#" .. hl .. "#" .. str .. "%*"
end

---Get a hl group's hex
---@param hl_group string
---@return table
function M.get_hl_hex(hl_group)
  assert(hl_group, "Error: must have hl group name")

  local hl = vim.api.nvim_get_hl(0, { name = hl_group })

  return {
    fg = hl.fg and ("#%06x"):format(hl.fg) or nil,
    bg = hl.bg and ("#%06x"):format(hl.bg) or nil,
  }
end

return M
