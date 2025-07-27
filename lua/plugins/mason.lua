return {
  "williamboman/mason.nvim",
  cmd = "Mason",
  build = ":MasonUpdate",
  opts = {
    ensure_installed = {
      "lua-language-server",
      "stylua",
      "shfmt",
      "eslint-lsp",
      "prettierd",
      "marksman",
      "markdownlint",
      "clangd",
      "clang-format",
      "latexindent",
      "bash-language-server",
      "pyright",
      "ruff",
      "debugpy",
      "black",
      "shellcheck",
      "html-lsp",
      "css-lsp",
      "json-lsp",
      "typescript-language-server",
      "gopls",
      "golangci-lint",
      "goimports",
      "golines",
      "gofumpt",
      "delve",
      "texlab",
      "harper-ls",
    },
    max_concurrent_installers = 10,
  },
  config = function(_, opts)
    require("mason").setup(opts)
    local mr = require "mason-registry"
    mr.refresh(function()
      for _, tool in ipairs(opts.ensure_installed) do
        local p = mr.get_package(tool)
        if not p:is_installed() then
          p:install()
        end
      end
    end)
  end,
}
