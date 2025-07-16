return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
  },
  opts = function()
    return {
      servers = {
        zls = {
          cmd = { "zls" },
          filetypes = { "zig", "zir" },
          root_dir = require("lspconfig.util").root_pattern("zls.json", "build.zig"),
          single_file_support = true,
        },
        harper_ls = {
          settings = {
            ["harper-ls"] = {
              userDictPath = "/usr/share/dict/words",
              fileDictPath = "/usr/share/dict/words",
              linters = {
                SpellCheck = true,
                SpelledNumbers = false,
                AnA = true,
                SentenceCapitalization = false,
                UnclosedQuotes = true,
                WrongQuotes = false,
                LongSentences = false,
                RepeatedWords = true,
                Spaces = false,
                Matcher = true,
                CorrectNumberSuffix = true,
              },
              codeActions = {
                ForceStable = false,
              },
              markdown = {
                IgnoreLinkTitle = false,
              },
              diagnosticSeverity = "hint",
              isolateEnglish = false,
              dialect = "American",
            },
          },
        },
        clangd = {
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern(
              "Makefile",
              "configure.ac",
              "configure.in",
              "config.h.in",
              "meson.build",
              "meson_options.txt",
              "build.ninja"
            )(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(
              fname
            ) or vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
          end,
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            -- "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--fallback-style=Google",
          },
          init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            clangdFileStatus = true,
          },
        },
        gopls = {
          filetypes = { "go", "gomod", "gowork", "gotmpl" },
          root_dir = require("lspconfig.util").root_pattern("go.work", "go.mod"),
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
              gofumpt = true,
              buildFlags = { "-tags", "integration" },
            },
          },
        },
        bashls = { filetypes = { "sh", "bash", "zsh" } },
        hyprls = { filetypes = { "hyprlang" } },
        lua_ls = {
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              codeLens = {
                enable = true,
              },
              completion = {
                callSnippet = "Replace",
              },
              doc = {
                privateName = { "^_" },
              },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
              },
              telemetry = { enable = false },
            },
          },
        },
        html = {},
        cssls = {},
        ts_ls = {},
        marksman = {},
        eslint = {},
        texlab = {},
        pyright = {},
      },
    }
  end,
  config = function(_, opts)
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
      underline = true,
      severity_sort = true,
      update_in_insert = false,

      virtual_lines = false,
      virtual_text = {
        current_line = false,
        severity = {
          min = vim.diagnostic.severity.WARN,
          max = vim.diagnostic.severity.ERROR,
        },
        format = function(diagnostic)
          return diagnostic.message .. " "
        end,
        spacing = 4,
        source = "if_many",
        prefix = icons.SquarePrefix,
      },
      float = {
        focusable = true,
        -- style = "minimal",
        -- source = "always",
        header = "",
        prefix = "",
        format = function(diagnostic)
          return string.format("%s\n(%s) [%s]", diagnostic.message, diagnostic.source, diagnostic.code)
        end,
      },
    }

    -- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    --   border = "rounded",
    --   -- focusable = false,
    --   -- relative = "cursor",
    -- })
    -- require("lspconfig.ui.windows").default_options.border = "none"

    local on_attach = function(client, bufnr)
      local optss = { buffer = bufnr, silent = true }

      if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })

        vim.keymap.set("n", "<leader>h", function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = bufnr })
        end, optss)
      end

      if vim.lsp.codelens and client:supports_method "textDocument/codeLens" then
        vim.lsp.codelens.refresh()
        vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
          buffer = bufnr,
          callback = vim.lsp.codelens.refresh,
        })

        vim.keymap.set({ "n", "v" }, "<leader>cl", vim.lsp.codelens.run, optss)
        vim.keymap.set("n", "<leader>cr", vim.lsp.codelens.refresh, optss)
      end

      if client.server_capabilities.declarationProvider then
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, optss)
      end

      if client.server_capabilities.definitionProvider then
        vim.keymap.set("n", "gd", function()
          require("fzf-lua").lsp_definitions {
            ignore_current_line = true,
          }
        end, optss)
      end

      if client.server_capabilities.implementationProvider then
        vim.keymap.set("n", "gi", function()
          require("fzf-lua").lsp_implementations {
            ignore_current_line = true,
          }
        end)
      end

      if client.server_capabilities.referencesProvider then
        vim.keymap.set("n", "gr", function()
          require("fzf-lua").lsp_references {
            ignore_current_line = true,
          }
        end)
      end

      if client.server_capabilities.typeDefinitionProvider then
        vim.keymap.set("n", "gy", function()
          require("fzf-lua").lsp_typedefs {
            ignore_current_line = true,
          }
        end)
      end

      if client.server_capabilities.codeActionProvider then
        vim.keymap.set({ "n", "v" }, "<leader>ca", function()
          require("fzf-lua").lsp_code_actions {}
        end)
      end

      vim.keymap.set("n", "K", vim.lsp.buf.hover, optss)
      vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, optss)

      vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, optss)
      vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, optss)
      vim.keymap.set("n", "<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, optss)
      vim.keymap.set("n", "ge", vim.diagnostic.open_float, optss)
      -- vim.keymap.set("n", "<leader>q", vim.diagnostic.setqflist, opts)
      -- vim.keymap.set("n", "<leader>f", function()
      --   vim.lsp.buf.format { async = true }
      -- end, optss)

      if client.server_capabilities.documentSymbolProvider then
        require("nvim-navic").attach(client, bufnr)
      end
    end

    ---@class lsp.ClientCapabilities
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.offsetEncoding = "utf-8"
    capabilities.workspace = {
      fileOperations = {
        didRename = true,
        willRename = true,
      },
    }

    local lspconfig = require "lspconfig"

    local servers = opts.servers
    for server in pairs(servers) do
      local server_opts = vim.tbl_deep_extend(
        "force",
        { capabilities = vim.deepcopy(capabilities) },
        { on_attach = on_attach },
        { flags = { debounce_text_changes = 300 } },
        servers[server] or {}
      )

      lspconfig[server].setup(server_opts)
    end
  end,
}
