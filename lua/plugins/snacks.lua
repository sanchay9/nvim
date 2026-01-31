return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    quickfile = { enabled = true },
    words = { enabled = true, debounce = 100, notify_jump = true },
    notifier = { enabled = true },
    statuscolumn = { enabled = true },
    image = { enabled = true },
    indent = {
      enabled = true,
      indent = {
        char = "▏", -- '▏', '┊', '|', '¦', '┆'
      },
      filter = function(buf)
        return vim.g.snacks_indent ~= false
          and vim.b[buf].snacks_indent ~= false
          and vim.bo[buf].buftype == ""
          and vim.bo[buf].filetype ~= "http"
          and vim.bo[buf].filetype ~= "markdown"
      end,
      scope = {
        enabled = true,
        priority = 200,
        char = "▏", -- '▏', '┊', '|', '¦', '┆'
        underline = true,
        only_current = true,
      },
    },
    dashboard = {
      preset = {
        header = require("banners")["vim"],
        keys = {
          { icon = " ", key = "w", desc = "notes", action = ":cd ~/docs/notes/personal | e index.md" },
          {
            icon = "",
            key = "c",
            desc = "confs",
            action = function()
              local config_dir = vim.fn.stdpath "config"
              Snacks.picker.files {
                cwd = config_dir,
                layout = "select",
                on_close = function()
                  vim.cmd.cd(config_dir)
                end,
              }
            end,
          },
          { icon = " ", key = "q", desc = "quit", action = ":qa" },
        },
      },
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup", padding = 2 },
      },
    },
    picker = {
      ui_select = true,
      exclude = {
        "vendor",
      },
    },
    scroll = { enabled = true },
  },
  -- stylua: ignore
  keys = {
    { "]]", function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference" },
    { "[[", function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference" },
    { "<leader>gx", function() Snacks.gitbrowse() end, desc = "Git Browse", },
    { "<leader><esc>", function() Snacks.notifier.show_history() end, desc = "Notification History" },
    { "<leader>,", function() Snacks.dashboard() end, desc = "Dashboard" },
    { "<leader>G", function() Snacks.lazygit() end, desc = "Lazygit", mode = { "n", "t" } },
    { "<leader>Z",  function() Snacks.zen() end, desc = "Toggle Zen Mode" },
    { "<leader>F",  function() Snacks.zen.zoom() end, desc = "Toggle Zoom", mode = {"n", "t"} },

    { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
    { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files (Root Dir)" },
    { "<leader>f.", function() Snacks.picker.files({ cwd = vim.fn.expand("%:p:h") }) end, desc = "Find Files (cwd)" },
    { "<leader>gg", function() Snacks.picker.grep() end, desc = "Grep (Root Dir)" },
    { "<leader>*", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
    { "<leader>i", function() Snacks.picker.icons() end, desc = "Icons" },
    { "<leader>g.", function() Snacks.picker.grep({ cwd = vim.fn.expand("%:p:h") }) end, desc = "Grep (cwd)" },
    { "<leader>b", function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<leader>hh", function() Snacks.picker.help() end, desc = "Help Pages" },
    { "<leader>r", function() Snacks.picker.recent() end, desc = "Recent" },
    { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
    { "<leader>/", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
  },
}
