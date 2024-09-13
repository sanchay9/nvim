return {
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    -- stylua: ignore
    keys = {
      { "<leader>ff",    "<cmd>lua require('fzf-lua').files()<cr>",                                            desc = "Find Files" },
      { "<leader>f.",    "<cmd>lua require('fzf-lua').files({ cwd = vim.fn.expand('%:p:h') })<cr>",            desc = "Find Files in cwd", },
      { "<leader>gg",    "<cmd>lua require('fzf-lua').live_grep_native()<cr>",                                 desc = "Grep" },
      { "<leader>g.",    "<cmd>lua require('fzf-lua').live_grep_native({ cwd = vim.fn.expand('%:p:h') })<cr>", desc = "Grep in cwd", },
      { "<leader>r",     "<cmd>lua require('fzf-lua').oldfiles()<cr>",                                         desc = "Recent Files" },
      { "<leader>hh",    "<cmd>lua require('fzf-lua').helptags()<cr>",                                         desc = "Help" },
      { "<leader>b",     "<cmd>lua require('fzf-lua').buffers()<cr>",                                          desc = "Buffers", },
      { "<leader><esc>", "<cmd>lua require('fzf-lua').files({ resume = true })<cr>",                           desc = "Resume last prompt", },
      -- { "<leader>.", "<cmd>lua require'telescope.builtin'.symbols{ sources = {'nerd'} }<cr>", desc = "Nerd Font Symbols", },
      { "<leader>/",     "<cmd>lua require('fzf-lua').lgrep_curbuf()<cr>",                                     desc = "Fuzzy Search Current Buffer", },
    },
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("fzf-lua").register_ui_select(function(_, items)
          local min_h, max_h = 0.15, 0.70
          local h = (#items + 4) / vim.o.lines
          if h < min_h then
            h = min_h
          elseif h > max_h then
            h = max_h
          end
          return { winopts = { height = h, width = 0.60, row = 0.40 } }
        end)

        return vim.ui.select(...)
      end
    end,
    opts = {
      file_ignore_patterns = { "vendor/.*", "node_modules/.*", ".*%.jpg", ".*%.png", ".*%.gif", ".*%.jpeg" },
      keymap = {
        builtin = {
          ["<leader>p"] = "toggle-preview",
          ["<leader>f"] = "toggle-fullscreen",
          ["<C-f>"] = "preview-page-down",
          ["<C-b>"] = "preview-page-up",
        },
      },
      builtin = {
        extensions = {
          ["dir"] = { "ls" },
        },
      },
      global_git_icons = false,
      winopts = {
        height = 0.6,
        -- width = 0.6,
        -- row = 0.5,
        -- border = "none",
      },
      fzf_opts = {
        ["--no-info"] = "",
        ["--info"] = "hidden",
        -- ["--padding"] = "2%,2%,2%,2%",
        ["--header"] = " ",
        ["--pointer"] = "▌",
      },
      files = {
        file_icons = true,
        prompt = " ∷ ",
        preview_opts = "hidden",
        no_header = true,
        cwd_header = false,
        cwd_prompt = false,
      },
      grep = {
        prompt = " ∷ ",
        header_prefix = " ",
      },
      buffers = {
        formatter = "path.filename_first",
        prompt = " ∷ ",
        preview_opts = "hidden",
        no_header = true,
        fzf_opts = { ["--delimiter"] = " ", ["--with-nth"] = "-1.." },
      },
      helptags = {
        prompt = "💡:",
        preview_opts = "hidden",
        winopts = {
          row = 1,
          width = vim.api.nvim_win_get_width(0),
          height = 0.3,
        },
      },
      git = {
        bcommits = {
          prompt = "logs:",
          cmd = "git log --color --pretty=format:'%C(yellow)%h%Creset %Cgreen%><(12)%cr%><|(12)%Creset %s' <file>",
          preview = "git show --stat --color --format='%C(cyan)%an%C(reset)%C(bold yellow)%d%C(reset): %s' {1} -- <file>",
          preview_opts = "nohidden",
          winopts = {
            preview = {
              layout = "vertical",
              vertical = "right:50%",
              wrap = "wrap",
            },
            row = 1,
            width = vim.api.nvim_win_get_width(0),
            height = 0.3,
          },
        },
        branches = {
          prompt = "branches:",
          cmd = "git branch --all --color",
          winopts = {
            preview = {
              layout = "vertical",
              vertical = "right:50%",
              wrap = "wrap",
            },
            row = 1,
            width = vim.api.nvim_win_get_width(0),
            height = 0.3,
          },
        },
      },
      autocmds = {
        prompt = "autocommands:",
        winopts = {
          width = 0.8,
          height = 0.7,
          preview = {
            layout = "horizontal",
            horizontal = "down:40%",
            wrap = "wrap",
          },
        },
      },
      keymaps = {
        prompt = "keymaps:",
        winopts = {
          width = 0.8,
          height = 0.7,
        },
        actions = {
          ["default"] = function(selected)
            local lines = vim.split(selected[1], "│", {})
            local mode, key = lines[1]:gsub("%s+", ""), lines[2]:gsub("%s+", "")
            vim.cmd("verbose " .. mode .. "map " .. key)
          end,
        },
      },
      highlights = {
        prompt = "highlights:",
        winopts = {
          width = 0.8,
          height = 0.7,
          preview = {
            layout = "horizontal",
            horizontal = "down:40%",
            wrap = "wrap",
          },
        },
        actions = {
          ["default"] = function(selected)
            print(vim.cmd.highlight(selected[1]))
          end,
        },
      },
      lsp = {
        code_actions = {
          prompt = "code actions:",
          previewer = "codeaction_native",
          preview_pager = "delta --side-by-side --width=$FZF_PREVIEW_COLUMNS --hunk-header-style='omit' --file-style='omit'",
          winopts = {
            width = 0.8,
            height = 0.7,
            preview = {
              layout = "horizontal",
              horizontal = "up:75%",
            },
          },
        },
      },
    },
  },
}
