return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {
      ui = {
        icons = {
          package_pending = " ",
          package_installed = " ",
          package_uninstalled = "󰚌 ",
        },
      },
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
        "bash-language-server",
        "pyright",
        "black",
        "shellcheck",
        "html-lsp",
        "css-lsp",
        "typescript-language-server",
        "gopls",
        "golangci-lint",
        "goimports",
        "golines",
        "texlab",
      },

      max_concurrent_installers = 10,
    },
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require "mason-registry"
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },
}
