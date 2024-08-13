return {
  {
    "goolord/alpha-nvim",
    cmd = "Alpha",
    keys = {
      { "<leader>,", "<cmd>Alpha<cr>", desc = "open alpha" },
    },
    config = function()
      local db = require "alpha.themes.dashboard"
      local stats = require("lazy").stats()

      -- local term_height = 10
      -- require "alpha.term"
      -- db.section.header = {
      --   type = "terminal",
      --   command = "neo --fps=20 --speed=5 -D -m 'NEO VIM' -d 0.5 -l 1,1",
      --   width = 60,
      --   height = term_height,
      --   opts = {
      --     redraw = true,
      --     window_config = {},
      --   },
      -- }

      local logo = require("banners")["vim"]
      db.section.header.val = logo
      -- db.section.header.val = vim.split(logo, "\n")

      -- db.section.footer.val = require "alpha.fortune"
      -- vim
      --   .system({
      --     "curl",
      --     "https://vtip.43z.one",
      --   })
      --   :wait().stdout,
      local project_list = {
        vim.fn.expand "~" .. "/.config",
        vim.fn.expand "~" .. "/bin",
        vim.fn.expand "~" .. "/notes",
      }

      db.section.buttons.val = {
        db.button("w", "  Notes", "<cmd>cd ~/docs/notes | e index.md<cr>"),
        -- db.button("c", "  Config", "<cmd>cd ~/.config/nvim | lua require('fzf-lua').args()<cr>"),
        db.button("c", "  Workdirs", function()
          local fzf_lua = require "fzf-lua"
          fzf_lua.files {
            fzf_opts = {
              ["--preview"] = function(selected)
                local newcwd = vim.fs.normalize(selected[1]:match "[^ ]*$")
                return vim.fn.system("eza --tree --icons " .. newcwd)
              end,
            },
            cmd = "fd --min-depth 1 --max-depth 1 --type d . ~ ~/work ~/work/learngo ~/personal ~/.config",
            actions = {
              ["default"] = function(selected)
                if not selected[1] then
                  return
                end
                -- local newcwd = vim.fs.normalize(selected[1]:match "[^ ]*$")
                local p = string.find(selected[1], "~")
                if p == nil then
                  vim.notify("no ~ in path", vim.log.levels.ERROR)
                  return
                end
                local newcwd = string.sub(selected[1], p)
                fzf_lua.files {
                  cwd = newcwd,
                  actions = {
                    ["default"] = function(selecte, opts)
                      require("fzf-lua").actions.file_edit(selecte, opts)
                      vim.cmd("cd " .. newcwd)
                    end,
                  },
                }
              end,
            },
          }
        end),
        db.button("q", "  Quit", vim.cmd.q),
      }

      for _, button in ipairs(db.section.buttons.val) do
        button.opts.hl = "AlphaButtons"
        button.opts.hl_shortcut = "AlphaShortcut"
      end
      db.section.header.opts.hl = "AlphaHeader"
      db.section.buttons.opts.hl = "AlphaButtons"
      db.section.footer.opts.hl = "AlphaFooter"

      db.config.layout = {
        { type = "padding", val = 6 },
        db.section.header,
        -- { type = "padding", val = term_height + 7 },
        { type = "padding", val = 2 },
        db.section.buttons,
        { type = "padding", val = 2 },
        db.section.footer,
      }

      vim.api.nvim_create_autocmd("User", {
        once = true,
        pattern = "LazyVimStarted",
        callback = function()
          db.section.footer.val = "⚡ Neovim loaded "
            .. stats.loaded
            .. "/"
            .. stats.count
            .. " plugins in "
            .. (math.floor(stats.startuptime * 100 + 0.5) / 100)
            .. "ms"
          pcall(vim.cmd.AlphaRedraw)
        end,
      })

      require("alpha").setup(db.opts)
    end,
  },
}
