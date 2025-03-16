local mode = "light"
if
  vim.uv.os_uname().sysname == "Darwin"
    and vim.system({ "defaults", "read", "-g", "AppleInterfaceStyle" }):wait().stdout == "Dark\n"
  or vim.system({ "gsettings", "get", "org.gnome.desktop.interface", "color-scheme" }):wait().stdout == "'prefer-dark'\n"
  or vim
      .system({
        "gdbus",
        "call",
        "--session",
        "--dest=org.freedesktop.portal.Desktop",
        "--object-path=/org/freedesktop/portal/desktop",
        "--method=org.freedesktop.portal.Settings.Read",
        "org.freedesktop.appearance",
        "color-scheme",
      })
      :wait().stdout
      :sub(11, 11)
    == "1"
then
  mode = "dark"
end

local file = io.open(os.getenv "XDG_CACHE_HOME" .. "/swcs.json", "r")
if file then
  local content = file:read "*all"
  file:close()
  local data = vim.json.decode(content)
  vim.cmd.colorscheme(data.neovim_theme[data[mode .. "_theme"]])
else
  vim.cmd.colorscheme "tokyonight"
  vim.opt.background = mode
end

if vim.g.conf.border ~= "none" then
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end
