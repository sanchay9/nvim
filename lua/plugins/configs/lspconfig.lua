vim.fn.sign_define(
  "DiagnosticSignError",
  { text = "󰅙", numhl = "DiagnosticSignError", texthl = "DiagnosticSignError" }
)
vim.fn.sign_define("DiagnosticSignWarn", { text = "", numhl = "DiagnosticSignWarn", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", numhl = "DiagnosticSignHint", texthl = "DiagnosticSignHint" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "󰋼", numhl = "DiagnosticSignInfo", texthl = "DiagnosticSignInfo" })

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

  local methods = vim.lsp.protocol.Methods
  if client.supports_method(methods.textDocument_inlayHint) then
    vim.keymap.set("n", "<leader>th", function()
      vim.lsp.inlay_hint(bufnr, nil)
    end, { desc = "[t]oggle inlay [h]ints" })
  end
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  -- vim.keymap.set("i", "<c-k>", vim.lsp.buf.signature_help, opts)
  vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts)
  vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
  -- vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<leader>rn", function()
    require("plugins.configs.renamer").open()
  end, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "ge", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
  vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)
  vim.keymap.set("n", "<leader>l", function()
    vim.lsp.buf.format { async = true }
  end, opts)

  -- if client.server_capabilities.signatureHelpProvider then
  --   require("plugins.configs.signature").setup(client)
  -- end

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

-- vim.api.nvim_create_autocmd("LspAttach", {
--     callback = function(args)
--         local client = vim.lsp.get_client_by_id(args.data.client_id)
--         if client.server_capabilities.hoverProvider then
--             vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = args.buf })
--         end
--         if client.server_capabilities.signatureHelpProvider then
--             vim.keymap.set({ "n", "i" }, "<c-k>", vim.lsp.buf.signature_help, { buffer = args.buf })
--         end
--         if client.server_capabilities.declarationProvider then
--             vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = args.buf })
--         end
--         if client.server_capabilities.definitionProvider then
--             vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = args.buf })
--         end
--         if client.server_capabilities.typeDefinitionProvider then
--             vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, { buffer = args.buf })
--         end
--         if client.server_capabilities.implementationProvider then
--             vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = args.buf })
--         end
--         if client.server_capabilities.referencesProvider then
--             vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = args.buf })
--         end
--         if client.server_capabilities.renameProvider then
--             vim.keymap.set("n", "cr", vim.lsp.buf.rename, { buffer = args.buf })
--         end
--         if client.server_capabilities.codeActionProvider then
--             vim.keymap.set("n", "cx", vim.lsp.buf.code_action, { buffer = args.buf })
--         end

--         vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { buffer = args.buf })
--         vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { buffer = args.buf })
--         vim.keymap.set("n", "<space>", vim.diagnostic.open_float, { buffer = args.buf })
--         vim.api.nvim_create_user_command("Dllist", vim.diagnostic.setloclist, {})
--         vim.api.nvim_create_user_command("Dclist", vim.diagnostic.setqflist, {})
--     end,
-- })
