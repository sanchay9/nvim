return {
  {
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim" },
    event = "BufWritePre",
    cmd = "ConformInfo",
    config = function(_, opts)
      require("conform").setup {
        format_on_save = {
          -- These options will be passed to conform.format()
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
          markdown = { "prettierd" },
          latex = { "latexindent" },
          json = { "jq" },
          sh = { "shfmt" },
          zsh = { "shfmt" },
          cpp = { "clang-format" },
          sql = { "sqlfluff" },
          ["*"] = { "trim_whitespace" },
        },
        formatters = {
          sqlfluff = {
            args = { "format", "--dialect=postgres", "-" },
          },
        },
      }
    end,
  },
}
