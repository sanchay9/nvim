require "options"
require "autocmds"
require "mappings"

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
  performance = {
    rtp = {
      disabled_plugins = {
        "2html_plugin",
        "tohtml",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "logipat",
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
        "matchit",
        "tar",
        "tarPlugin",
        "rrhelper",
        "spellfile_plugin",
        "vimball",
        "vimballPlugin",
        "zip",
        "zipPlugin",
        "tutor",
        "rplugin",
        "syntax",
        "synmenu",
        "optwin",
        "compiler",
        "bugreport",
        "ftplugin",
      },
    },
  },
})

local mode = "dark"
if
  vim
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
    :sub(11, 11) == "2"
then
  mode = "light"
end

local file = io.open(os.getenv "HOME" .. "/.cache/swcs.json", "r")
if file then
  local content = file:read "*all"
  file:close()
  local data = vim.json.decode(content)
  vim.cmd.colorscheme(data.neovim_theme[data[mode .. "_theme"]])
else
  vim.cmd.colorscheme "tokyonight"
end
