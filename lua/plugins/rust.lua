return {
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    ft = { "rust" },
    opts = {
      server = {
        on_attach = function(_, bufnr)
          local optss = { buffer = bufnr, silent = true }

          vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })

          vim.keymap.set("n", "<leader>h", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = bufnr })
          end, optss)

          vim.lsp.codelens.refresh()
          vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
            buffer = bufnr,
            callback = vim.lsp.codelens.refresh,
          })

          vim.keymap.set({ "n", "v" }, "<leader>cl", vim.lsp.codelens.run, optss)
          vim.keymap.set("n", "<leader>cr", vim.lsp.codelens.refresh, optss)

          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, optss)

          vim.keymap.set("n", "gd", function()
            require("fzf-lua").lsp_definitions {
              ignore_current_line = true,
            }
          end, optss)

          vim.keymap.set("n", "gi", function()
            require("fzf-lua").lsp_implementations {
              ignore_current_line = true,
            }
          end)

          vim.keymap.set("n", "gr", function()
            require("fzf-lua").lsp_references {
              ignore_current_line = true,
            }
          end)

          vim.keymap.set("n", "gy", function()
            require("fzf-lua").lsp_typedefs {
              ignore_current_line = true,
            }
          end)

          vim.keymap.set({ "n", "v" }, "<leader>ca", function()
            require("fzf-lua").lsp_code_actions {}
          end)

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

          vim.keymap.set("n", "<leader>cR", function()
            vim.cmd.RustLsp "codeAction"
          end, { desc = "Code Action", buffer = bufnr })
          vim.keymap.set("n", "<leader>dr", function()
            vim.cmd.RustLsp "debuggables"
          end, { desc = "Rust Debuggables", buffer = bufnr })
        end,
        default_settings = {
          -- rust-analyzer language server configuration
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              buildScripts = {
                enable = true,
              },
            },
            -- Add clippy lints for Rust if using rust-analyzer
            checkOnSave = true,
            -- Enable diagnostics if using rust-analyzer
            diagnostics = {
              enable = true,
            },
            procMacro = {
              enable = true,
              ignored = {
                ["async-trait"] = { "async_trait" },
                ["napi-derive"] = { "napi" },
                ["async-recursion"] = { "async_recursion" },
              },
            },
            files = {
              excludeDirs = {
                ".direnv",
                ".git",
                ".github",
                ".gitlab",
                "bin",
                "node_modules",
                "target",
                "venv",
                ".venv",
              },
            },
          },
        },
      },
    },
    config = function(_, opts)
      local package_path = require("mason-registry").get_package("codelldb"):get_install_path()
      local codelldb = package_path .. "/extension/adapter/codelldb"
      local library_path = package_path .. "/extension/lldb/lib/liblldb.dylib"
      local uname = io.popen("uname"):read "*l"
      if uname == "Linux" then
        library_path = package_path .. "/extension/lldb/lib/liblldb.so"
      end
      opts.dap = {
        adapter = require("rustaceanvim.config").get_codelldb_adapter(codelldb, library_path),
      }

      vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})
      if vim.fn.executable "rust-analyzer" == 0 then
        vim.notify(
          "**rust-analyzer** not found in PATH, please install it.\nhttps://rust-analyzer.github.io/",
          vim.log.levels.ERROR
        )
      end
    end,
  },

  {
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    opts = {
      completion = {
        crates = {
          enabled = true,
        },
      },
      lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
      },
    },
  },
}
