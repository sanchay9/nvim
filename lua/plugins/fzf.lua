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
      { "<leader>/",     "<cmd>lua require('fzf-lua').lgrep_curbuf()<cr>",                                     desc = "Fuzzy Search Current Buffer", },
    },
    init = function()
      require("fzf-lua").register_ui_select(function(fzf_opts, items)
        return vim.tbl_deep_extend("force", fzf_opts, {
          prompt = "  ",
          winopts = {
            title = " " .. vim.trim((fzf_opts.prompt or "Select"):gsub("%s*:%s*$", "")) .. " ",
            title_pos = "center",
          },
        }, fzf_opts.kind == "codeaction" and {
          winopts = {
            layout = "vertical",
            -- height is number of items minus 15 lines for the preview, with a max of 80% screen height
            height = math.floor(math.min(vim.o.lines * 0.8 - 16, #items + 2) + 0.5) + 16,
            width = 0.5,
            preview = {
              layout = "vertical",
              vertical = "down:15,border-top",
            },
          },
        } or {
          winopts = {
            width = 0.5,
            -- height is number of items, with a max of 80% screen height
            height = math.floor(math.min(vim.o.lines * 0.8, #items + 2) + 0.5),
          },
        })
      end)
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
          ["<A-p>"] = "toggle-preview",
          ["<A-f>"] = "toggle-fullscreen",
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
