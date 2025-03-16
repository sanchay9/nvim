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
      defaults = { git_icons = false },
      winopts = {
        height = 0.6,
        -- width = 0.6,
        -- row = 0.5,
        border = "none",
        -- border  = { " ", " ", " ", " ", "", "", "", " " }, -- "solid-top" (+side margins)
        title = "",
        preview = {
          border = "none",
          scrollbar = "border",
        },
      },
      keymap = {
        builtin = {
          ["<leader>p"] = "toggle-preview",
          ["<leader>f"] = "toggle-fullscreen",
          ["<C-f>"] = "preview-page-down",
          ["<C-b>"] = "preview-page-up",
        },
      },
      fzf_opts = {
        ["--no-info"] = "",
        ["--info"] = "hidden",
        -- ["--padding"] = "2%,2%,2%,2%",
        ["--header"] = " ",
        ["--pointer"] = "▌",
      },
      fzf_colors = true,
      file_ignore_patterns = { "vendor/.*", "node_modules/.*", ".*%.jpg", ".*%.png", ".*%.gif", ".*%.jpeg" },
      previewers = {
        builtin = {
          syntax_limit_b = 100 * 1024, -- 100KB
        },
      },
      builtin = {
        extensions = {
          ["dir"] = { "ls" },
        },
      },
      files = {
        -- TODO: set all prompts the same
        prompt = " ∷ ",
        no_header = true,
        cwd_header = false,
        cwd_prompt = false,
      },
      grep = {
        prompt = " ∷ ",
        -- no_header = true,
      },
      buffers = {
        formatter = "path.filename_first",
        prompt = " ∷ ",
        no_header = true,
        fzf_opts = { ["--delimiter"] = " ", ["--with-nth"] = "-1.." },
      },
      lsp = {
        jump1 = true,
        code_actions = {
          previewer = "codeaction_native",
        },
      },
    },
  },
}
