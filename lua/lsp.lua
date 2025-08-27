local icons = require("icons").diagnostics
local methods = vim.lsp.protocol.Methods

local M = {}

---@param client vim.lsp.Client
---@param bufnr integer
local function on_attach(client, bufnr)
  local function keymap(lhs, rhs, desc, mode)
    mode = mode or "n"
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
  end
  local optss = { buffer = bufnr, silent = true }

  if client.server_capabilities.documentSymbolProvider then
    require("nvim-navic").attach(client, bufnr)
  end

  vim.lsp.document_color.enable(true, bufnr, { style = "virtual" })

  vim.keymap.set({ "n", "x" }, "grc", function()
    vim.lsp.document_color.color_presentation()
  end, { buffer = bufnr, desc = "Change color representation" })

  if vim.lsp.codelens and client:supports_method "textDocument/codeLens" then
    vim.lsp.codelens.refresh()
    vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
      buffer = bufnr,
      callback = vim.lsp.codelens.refresh,
    })

    vim.keymap.set({ "n", "v" }, "<leader>cl", vim.lsp.codelens.run, optss)
    vim.keymap.set("n", "<leader>cr", vim.lsp.codelens.refresh, optss)
  end

  if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlineCompletion) then
    vim.lsp.inline_completion.enable(true)
  end

  if client.server_capabilities.codeActionProvider then
    vim.keymap.set({ "n", "x" }, "gra", function()
      require("fzf-lua").lsp_code_actions {}
    end)
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

  vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Show hover information" })
  vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "Show signature help" })

  vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, optss)
  vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, optss)
  vim.keymap.set("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, optss)

  if client.server_capabilities.implementationProvider then
    vim.keymap.set("n", "gri", function()
      require("fzf-lua").lsp_implementations {
        ignore_current_line = true,
      }
    end)
  end

  -- if client:supports_method(methods.textDocument_definition) then
  --   keymap("gd", function()
  --     require("fzf-lua").lsp_definitions { jump1 = true }
  --   end, "Go to definition")
  --   keymap("gD", function()
  --     require("fzf-lua").lsp_definitions { jump1 = false }
  --   end, "Peek definition")
  -- end

  if client.server_capabilities.referencesProvider then
    vim.keymap.set("n", "grr", function()
      require("fzf-lua").lsp_references {
        ignore_current_line = true,
      }
    end, { buffer = bufnr, desc = "Go to references" })
  end

  if client.server_capabilities.typeDefinitionProvider then
    vim.keymap.set("n", "gy", function()
      require("fzf-lua").lsp_typedefs {}
    end, { buffer = bufnr, desc = "Go to type definition" })
  end

  if client.server_capabilities.inlayHintProvider then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })

    keymap("<leader>h", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = bufnr })
    end, "Toggle inlay hints")
  end

  keymap("<leader>fs", "<cmd>FzfLua lsp_document_symbols<cr>", "Document symbols")

  keymap("[d", function()
    vim.diagnostic.jump { count = -1 }
  end, "Previous diagnostic")
  keymap("]d", function()
    vim.diagnostic.jump { count = 1 }
  end, "Next diagnostic")
  keymap("[e", function()
    vim.diagnostic.jump { count = -1, severity = vim.diagnostic.severity.ERROR }
  end, "Previous error")
  keymap("]e", function()
    vim.diagnostic.jump { count = 1, severity = vim.diagnostic.severity.ERROR }
  end, "Next error")

  keymap("<leader>fs", "<cmd>FzfLua lsp_document_symbols<cr>", "Document symbols")
  vim.keymap.set("n", "ge", vim.diagnostic.open_float, { buffer = bufnr, desc = "Show diagnostics under cursor" })

  if client:supports_method(methods.textDocument_signatureHelp) then
    keymap("<C-k>", function()
      if require("blink.cmp.completion.windows.menu").win:is_open() then
        require("blink.cmp").hide()
      end

      vim.lsp.buf.signature_help()
    end, "Signature help", "i")
  end

  if client:supports_method(methods.textDocument_documentHighlight) then
    local under_cursor_highlights_group = vim.api.nvim_create_augroup("cursor_highlights", { clear = false })
    vim.api.nvim_create_autocmd({ "CursorHold", "InsertLeave" }, {
      group = under_cursor_highlights_group,
      desc = "Highlight references under the cursor",
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ "CursorMoved", "InsertEnter", "BufLeave" }, {
      group = under_cursor_highlights_group,
      desc = "Clear highlight references",
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end
end

-- Define the diagnostic signs.
for severity, icon in pairs(icons) do
  local hl = "DiagnosticSign" .. severity:sub(1, 1) .. severity:sub(2):lower()
  vim.fn.sign_define(hl, { text = icon, texthl = hl })
end

-- Diagnostic configuration.
vim.diagnostic.config {
  underline = true,
  severity_sort = true,
  update_in_insert = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = icons.Error,
      [vim.diagnostic.severity.WARN] = icons.Warn,
      [vim.diagnostic.severity.HINT] = icons.Hint,
      [vim.diagnostic.severity.INFO] = icons.Info,
    },
  },
  virtual_text = {
    current_line = false,
    severity = {
      min = vim.diagnostic.severity.WARN,
      max = vim.diagnostic.severity.ERROR,
    },
    spacing = 4,
    source = "if_many",
    prefix = icons.SquarePrefix,
    format = function(diagnostic)
      return diagnostic.message .. " "

      -- -- Use shorter, nicer names for some sources:
      -- local special_sources = {
      --   ["Lua Diagnostics."] = "lua",
      --   ["Lua Syntax Check."] = "lua",
      -- }
      --
      -- local message = icons[vim.diagnostic.severity[diagnostic.severity]]
      -- if diagnostic.source then
      --   message = string.format("%s %s", message, special_sources[diagnostic.source] or diagnostic.source)
      -- end
      -- if diagnostic.code then
      --   message = string.format("%s[%s]", message, diagnostic.code)
      -- end
      --
      -- return message .. " "
    end,
  },
  virtual_lines = false,
  float = {
    focusable = true,
    -- style = "minimal",
    -- source = "always",
    header = "",
    format = function(diagnostic)
      return string.format("%s\n(%s) [%s]", diagnostic.message, diagnostic.source, diagnostic.code)
    end,
    prefix = "",
    -- prefix = function(diag)
    --   local level = vim.diagnostic.severity[diag.severity]
    --   local prefix = string.format(" %s ", icons[level])
    --   return prefix, "Diagnostic" .. level:gsub("^%l", string.upper)
    -- end,
  },
}

-- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
--   border = "rounded",
--   -- focusable = false,
--   -- relative = "cursor",
-- })
-- require("lspconfig.ui.windows").default_options.border = "none"

-- Update mappings when registering dynamic capabilities.
local register_capability = vim.lsp.handlers[methods.client_registerCapability]
vim.lsp.handlers[methods.client_registerCapability] = function(err, res, ctx)
  local client = vim.lsp.get_client_by_id(ctx.client_id)
  if not client then
    return
  end

  on_attach(client, vim.api.nvim_get_current_buf())

  return register_capability(err, res, ctx)

  -- TODO: what to do of this?
  -- ---@class lsp.ClientCapabilities
  -- local capabilities = vim.lsp.protocol.make_client_capabilities()
  -- capabilities.offsetEncoding = "utf-8"
  -- capabilities.workspace = {
  --   fileOperations = {
  --     didRename = true,
  --     willRename = true,
  --   },
  -- }
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("LSP Attach", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client then
      on_attach(client, args.buf)
    end
  end,
})

vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
  once = true,
  callback = function()
    local server_configs = vim
      .iter(vim.api.nvim_get_runtime_file("lsp/*.lua", true))
      :map(function(file)
        return vim.fn.fnamemodify(file, ":t:r")
      end)
      :totable()
    vim.lsp.enable(server_configs)
  end,
})

return M
