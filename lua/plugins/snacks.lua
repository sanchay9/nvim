return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    quickfile = { enabled = true },
    words = { enabled = true },
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
        ---@type snacks.dashboard.Item[]
        keys = {
          { icon = " ", key = "w", desc = "notes", action = ":cd ~/docs/notes/personal | e index.md" },
          {
            icon = "",
            key = "c",
            desc = "workdirs",
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

          -- { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          -- { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          -- { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          -- { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          -- { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          -- { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          -- { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
          -- { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
          { icon = " ", key = "q", desc = "quit", action = ":qa" },
        },
      },
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
        -- vim.system({ "curl", "https://vtip.43z.one" }):wait().stdout,
      },
    },
  },
  -- stylua: ignore
  keys = {
    { "]]", function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" }, },
    { "[[", function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" }, },
    { "<leader>gx", function() Snacks.gitbrowse() end, desc = "Git Browse", },
    { "<leader>`", function() Snacks.notifier.show_history() end, desc = "Notification History" },
    { "<leader>,", function() Snacks.dashboard() end, desc = "Dashboard" },
  },
}
