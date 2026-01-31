return {
  "mason-org/mason.nvim",
  build = ":MasonUpdate",
  opts = {
    ensure_installed = {
      "copilot-language-server",
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
      "qmlls",
      "sqls",
      "sqlfluff",
      "yaml-language-server",
      "zls",
    },
    max_concurrent_installers = 10,
  },
  config = function(_, opts)
    require("mason").setup(opts)
    local mr = require "mason-registry"
    mr:on("package:install:success", function()
      vim.defer_fn(function()
        -- trigger FileType event to possibly load this newly installed LSP server
        require("lazy.core.handler.event").trigger {
          event = "FileType",
          buf = vim.api.nvim_get_current_buf(),
        }
      end, 100)
    end)

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
