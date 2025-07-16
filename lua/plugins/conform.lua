return {
  {
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim" },
    event = "BufWritePre",
    cmd = "ConformInfo",
    opts = {
      format_on_save = {
        timeout_ms = 3000,
        async = false,
        quiet = false,
        lsp_fallback = true,
      },
      formatters_by_ft = {
        lua = { "stylua" },
        go = { "goimports", "gofumpt" },
        html = { "prettierd" },
        css = { "prettierd" },
        javascript = { "prettierd" },
        http = { "kulala" },
        markdown = { "prettierd" },
        latex = { "latexindent" },
        json = { "jq" },
        sh = { "shfmt" },
        zsh = { "shfmt" },
        cpp = { "clang-format" },
        sql = { "sqlfluff" },
        rust = { "rustfmt" },
        python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
        ["*"] = { "trim_whitespace" },
      },
      formatters = {
        sqlfluff = {
          args = { "format", "--dialect=postgres", "-" },
        },
        kulala = {
          command = "kulala-fmt",
          args = { "format", "$FILENAME" },
          stdin = false,
        },
      },
    },
  },
}
