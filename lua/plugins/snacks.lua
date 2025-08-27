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
            icon = "",
            key = "c",
            desc = "dirs",
            action = function()
              local fzf_lua = require "fzf-lua"
              fzf_lua.files {
                cmd = "fd --min-depth 1 --max-depth 1 --type d . ~ ~/work ~/work/learngo ~/dev ~/.config 2>/dev/null",
                actions = {
                  ["enter"] = function(selected)
                    if not selected[1] then
                      return
                    end
                    local newcwd = string.sub(selected[1], 8)
                    fzf_lua.files {
                      cwd = newcwd,
                      actions = {
                        ["enter"] = function(selecte, opts)
                          require("fzf-lua").actions.file_edit(selecte, opts)
                          vim.cmd.cd(newcwd)
                        end,
                      },
                    }
                  end,
                },
              }
            end,
          },
          { icon = "󰒲 ", key = "l", desc = "lazy", action = ":Lazy" },
          { icon = " ", key = "q", desc = "quit", action = ":qa" },
        },
      },
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup", padding = 2 },
        {
          section = "terminal",
          cmd = "curl https://vtip.43z.one",
          -- cmd = "cbonsai -l -i -L 30",
          height = 10,
          ttl = 1,
        },
      },
    },
  },
  -- stylua: ignore
  keys = {
    { "]]", function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference" },
    { "[[", function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference" },
    { "<leader>gx", function() Snacks.gitbrowse() end, desc = "Git Browse", },
    { "<leader><esc>", function() Snacks.notifier.show_history() end, desc = "Notification History" },
    { "<leader>,", function() Snacks.dashboard() end, desc = "Dashboard" },
  },
}
