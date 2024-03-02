return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
  },
  config = function()
    vim.fn.sign_define(
      "DiagnosticSignError",
      { text = "󰅙", numhl = "DiagnosticSignError", texthl = "DiagnosticSignError" }
    )
    vim.fn.sign_define(
      "DiagnosticSignWarn",
      { text = "", numhl = "DiagnosticSignWarn", texthl = "DiagnosticSignWarn" }
    )
    vim.fn.sign_define(
      "DiagnosticSignHint",
      { text = "󰌵", numhl = "DiagnosticSignHint", texthl = "DiagnosticSignHint" }
    )
    vim.fn.sign_define(
      "DiagnosticSignInfo",
      { text = "󰋼", numhl = "DiagnosticSignInfo", texthl = "DiagnosticSignInfo" }
    )

    vim.diagnostic.config {
      -- virtual_text = false,
      virtual_text = {
        spacing = 20,
        -- format = function(diagnostic)
        --     if diagnostic.severity == vim.diagnostic.severity.ERROR then
        --         return string.format("E: %s", diagnostic.message)
        --     end
        --     return diagnostic.message
        -- end
      },
      float = {
        focusable = false,
        -- style = "minimal",
        border = "rounded",
        -- source = "always",
        header = "",
        prefix = "",
        format = function(diagnostic)
          return string.format("%s\n(%s) [%s]", diagnostic.message, diagnostic.source, diagnostic.code)
        end,
      },
      signs = true,
      underline = true,
      severity_sort = true,
      update_in_insert = true,
    }

    -- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    --   border = "rounded",
    -- })
    -- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    --   border = "rounded",
    --   -- focusable = false,
    --   -- relative = "cursor",
    -- })
    require("lspconfig.ui.windows").default_options.border = "none"

    local navic = require "nvim-navic"

    local on_attach = function(client, bufnr)
      local opts = { buffer = bufnr, silent = true }

      if client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
        vim.keymap.set("n", "<leader>th", function()
          vim.lsp.inlay_hint(bufnr, true)
        end, { desc = "[t]oggle inlay [h]ints" })
      end
      -- if client.server_capabilities.inlayHintProvider then
      --       vim.lsp.buf.inlay_hint(bufnr, true)
      --   end
      if client.server_capabilities.hoverProvider then
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      end
      if client.server_capabilities.declarationProvider then
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
      end
      if client.server_capabilities.definitionProvider then
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      end
      if client.server_capabilities.implementationProvider then
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
      end
      -- if client.server_capabilities.signatureHelpProvider then
      --   require("plugins.configs.signature").setup(client)
      --   vim.keymap.set("i", "<c-k>", vim.lsp.buf.signature_help, opts)
      -- end
      vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
      vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
      vim.keymap.set("n", "<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, opts)
      if client.server_capabilities.typeDefinitionProvider then
        vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
      end
      if client.server_capabilities.renameProvider then
        vim.keymap.set("n", "<leader>rn", function()
          require("plugins.configs.renamer").open()
        end, opts)
      end
      if client.server_capabilities.codeActionProvider then
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      end
      if client.server_capabilities.referencesProvider then
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
      end
      vim.keymap.set("n", "ge", vim.diagnostic.open_float, opts)
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
      vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)
      vim.keymap.set("n", "<leader>l", function()
        vim.lsp.buf.format { async = true }
      end, opts)

      -- require("illuminate").on_attach(client)

      if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
      end
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()

    -- nvim-cmp supports additional completion capabilities
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    capabilities.offsetEncoding = "utf-8"
    capabilities.textDocument.completion.completionItem = {
      documentationFormat = { "markdown", "plaintext" },
      snippetSupport = true,
      preselectSupport = true,
      insertReplaceSupport = true,
      labelDetailsSupport = true,
      deprecatedSupport = true,
      commitCharactersSupport = true,
      tagSupport = { valueSet = { 1 } },
      resolveSupport = {
        properties = {
          "documentation",
          "detail",
          "additionalTextEdits",
        },
      },
    }

    require("neodev").setup()
    local lspconfig = require "lspconfig"

    local servers = { "cssls", "tsserver", "html", "marksman", "eslint", "texlab", "pyright" }
    for _, lsp in ipairs(servers) do
      lspconfig[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = {
          debounce_text_changes = 300,
        },
        root_dir = vim.loop.cwd,
      }
    end

    lspconfig.clangd.setup {
      on_attach = on_attach,
      capabilities = capabilities,
      flags = {
        debounce_text_changes = 300,
      },
      root_dir = vim.loop.cwd,
      cmd = {
        "clangd",
        "--background-index",
        "--completion-style=bundled",
        -- "--header-insertion=never",
      },
    }

    lspconfig.gopls.setup {
      on_attach = on_attach,
      capabilities = capabilities,
      filetypes = { "go", "gomod", "gowork", "gotmpl" },
      root_dir = require("lspconfig/util").root_pattern("go.work", "go.mod"),
      settings = {
        gopls = {
          usePlaceholders = false,
          analyses = {
            unusedparams = true,
          },
          ["ui.inlayhint.hints"] = {
            compositeLiteralFields = true,
            constantValues = true,
            parameterNames = true,
          },
        },
      },
    }

    lspconfig.bashls.setup {
      on_attach = on_attach,
      capabilities = capabilities,
      filetypes = { "sh", "zsh" },
      flags = {
        debounce_text_changes = 300,
      },
    }

    lspconfig.lua_ls.setup {
      on_attach = on_attach,
      capabilities = capabilities,

      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
          runtime = { version = "LuaJIT" },
          workspace = {
            library = {
              [vim.fn.expand "$VIMRUNTIME/lua"] = true,
              [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
              [vim.fn.stdpath "config" .. "/meta"] = true,
              [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
            },
            maxPreload = 100000,
            preloadFileSize = 10000,
          },
          telemetry = { enable = false },
        },
      },
    }
  end,
}
