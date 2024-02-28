return {
  {
    "mhartington/formatter.nvim",
    event = "BufWritePre",
    config = function()
      require("formatter").setup {
        logging = true,
        log_level = vim.log.levels.WARN,
        filetype = {
          html = { require("formatter.filetypes.html").prettierd },
          css = { require("formatter.filetypes.css").prettierd },
          javascript = { require("formatter.filetypes.javascript").prettierd },
          markdown = { require("formatter.filetypes.markdown").prettierd },
          latex = { require("formatter.filetypes.latex").latexindent },
          json = { require("formatter.filetypes.json").jq },
          lua = { require("formatter.filetypes.lua").stylua },
          sh = { require("formatter.filetypes.sh").shfmt },
          zsh = { require("formatter.filetypes.sh").shfmt },
          cpp = { require("formatter.filetypes.cpp").clangformat },
          go = {
            require("formatter.filetypes.go").gofmt,
            require("formatter.filetypes.go").goimports,
            -- require("formatter.filetypes.go").golines,
          },
          python = { require("formatter.filetypes.python").black },
          ["*"] = { require("formatter.filetypes.any").remove_trailing_whitespace },
        },
      }

      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        command = "FormatWriteLock",
      })
    end,
  },
}
