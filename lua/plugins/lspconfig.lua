return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
  },
  config = function()
    local icons = require("icons").diagnostics
    vim.diagnostic.config {
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = icons.Error,
          [vim.diagnostic.severity.WARN] = icons.Warn,
          [vim.diagnostic.severity.HINT] = icons.Hint,
          [vim.diagnostic.severity.INFO] = icons.Info,
        },
      },
      -- virtual_text = false,
      virtual_text = {
        format = function(diagnostic)
          return diagnostic.message .. " "
        end,
        spacing = 4,
        source = "if_many",
        prefix = " ■",
      },
      inlay_hints = {
        enabled = true,
        exclude = { "vue" },
      },
      codelens = {
        enabled = false,
      },
      document_highlight = {
        enabled = true,
      },
      capabilities = {
        workspace = {
          fileOperations = {
            didRename = true,
            willRename = true,
          },
        },
      },
      float = {
        focusable = true,
        -- style = "minimal",
        border = "rounded",
        -- source = "always",
        header = "",
        prefix = "",
        format = function(diagnostic)
          return string.format("%s\n(%s) [%s]", diagnostic.message, diagnostic.source, diagnostic.code)
        end,
      },
      underline = true,
      severity_sort = true,
      update_in_insert = false,
    }

    -- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    --   border = "rounded",
    -- })
    -- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    --   border = "rounded",
    --   -- focusable = false,
    --   -- relative = "cursor",
    -- })
    -- require("lspconfig.ui.windows").default_options.border = "none"

    local navic = require "nvim-navic"

    local on_attach = function(client, bufnr)
      local opts = { buffer = bufnr, silent = true }

      if client.server_capabilities.inlayHintProvider then
        vim.keymap.set("n", "<leader>h", function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = bufnr })
        end, opts)
        vim.lsp.inlay_hint.enable()
      end
      if client.server_capabilities.declarationProvider then
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
      end
      if client.server_capabilities.definitionProvider then
        -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gd", "<cmd>FzfLua lsp_definitions jump_to_single_result=true ignore_current_line=true<cr>")
      end
      if client.server_capabilities.implementationProvider then
        -- vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set(
          "n",
          "gi",
          "<cmd>FzfLua lsp_implementations jump_to_single_result=true ignore_current_line=true<cr>"
        )
      end

      if client.supports_method "textDocument/codeLens" then
        vim.keymap.set("n", "<leader>cl", vim.lsp.codelens.run, opts)
        vim.keymap.set("n", "<leader>cr", vim.lsp.codelens.refresh, opts)
      end

      vim.keymap.set("n", "gy", "<cmd>FzfLua lsp_typedefs jump_to_single_result=true ignore_current_line=true<cr>")
      vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
      vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
      vim.keymap.set("n", "<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, opts)
      if client.server_capabilities.typeDefinitionProvider then
        vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
      end
      if client.server_capabilities.renameProvider then
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      end
      if client.server_capabilities.codeActionProvider then
        -- vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set({ "n", "v" }, "<leader>ca", function()
          require("fzf-lua").lsp_code_actions {
            winopts = {
              relative = "cursor",
              width = 0.6,
              height = 0.6,
              row = 1,
              preview = { vertical = "up:70%" },
            },
          }
        end)
      end
      if client.server_capabilities.referencesProvider then
        -- vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "gr", "<cmd>FzfLua lsp_references jump_to_single_result=true ignore_current_line=true<cr>")
      end
      vim.keymap.set("n", "ge", vim.diagnostic.open_float, opts)
      -- vim.keymap.set("n", "<leader>q", vim.diagnostic.setqflist, opts)
      vim.keymap.set("n", "<leader>f", function()
        vim.lsp.buf.format { async = true }
      end, opts)

      if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
      end
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()

    capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

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

    local lspconfig = require "lspconfig"

    local servers = { "cssls", "ts_ls", "html", "marksman", "eslint", "texlab", "pyright" }
    for _, lsp in ipairs(servers) do
      lspconfig[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = {
          debounce_text_changes = 300,
        },
        root_dir = vim.uv.cwd,
      }
    end

    lspconfig.clangd.setup {
      on_attach = on_attach,
      capabilities = capabilities,
      flags = {
        debounce_text_changes = 300,
      },
      root_dir = function(fname)
        return require("lspconfig.util").root_pattern(
          "Makefile",
          "configure.ac",
          "configure.in",
          "config.h.in",
          "meson.build",
          "meson_options.txt",
          "build.ninja"
        )(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(fname) or require(
          "lspconfig.util"
        ).find_git_ancestor(fname)
      end,
      cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        -- "--header-insertion=iwyu",
        "--completion-style=detailed",
        "--function-arg-placeholders",
        "--fallback-style=llvm",
      },
      init_options = {
        usePlaceholders = true,
        completeUnimported = true,
        clangdFileStatus = true,
      },
    }

    lspconfig.gopls.setup {
      on_attach = on_attach,
      capabilities = capabilities,
      filetypes = { "go", "gomod", "gowork", "gotmpl" },
      root_dir = require("lspconfig/util").root_pattern("go.work", "go.mod"),
      settings = {
        gopls = {
          codelenses = {
            generate = true, -- show the `go generate` lens.
            gc_details = false, -- Show a code lens toggling the display of gc's choices.
            test = true,
            tidy = true,
            vendor = true,
            regenerate_cgo = true,
            run_govulncheck = true,
            upgrade_dependency = true,
          },
          analyses = {
            unreachable = true,
            nilness = true,
            unusedparams = true,
            useany = true,
            unusedwrite = true,
            ST1003 = true,
            undeclaredname = true,
            fillreturns = true,
            nonewvars = true,
            fieldalignment = false,
            shadow = true,
          },
          hints = {
            compositeLiteralFields = true,
            constantValues = true,
            parameterNames = true,
            assignVariableTypes = false,
            compositeLiteralTypes = true,
            functionTypeParameters = true,
            rangeVariableTypes = true,
          },
          usePlaceholders = false,
          completeUnimported = true,
          staticcheck = true,
          matcher = "Fuzzy",
          diagnosticsDelay = "500ms",
          symbolMatcher = "fuzzy",
          semanticTokens = true,
          noSemanticString = true, -- disable semantic string tokens so we can use treesitter highlight injection
          gofumpt = true,
          buildFlags = { "-tags", "integration" },
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

    lspconfig.hyprls.setup {
      on_attach = on_attach,
      capabilities = capabilities,
      filetypes = { "hyprlang" },
    }

    lspconfig.lua_ls.setup {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        Lua = {
          codeLens = {
            enable = true,
          },
          hint = {
            enable = true,
            -- setType = false,
            -- paramType = true,
            -- paramName = "Disable",
            -- semicolon = "Disable",
            arrayIndex = "Disable",
          },
          diagnostics = { globals = { "vim", "hs", "spoon" } },
          runtime = { version = "LuaJIT" },
          workspace = {
            library = {
              [vim.fn.expand "$VIMRUNTIME/lua"] = true,
              [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
              [vim.fn.stdpath "config" .. "/meta"] = true,
              [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
              [vim.fn.expand "$HOME/.hammerspoon/Spoons/EmmyLua.spoon/annotations"] = true,
              ["${3rd}/luv/library"] = true,
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
