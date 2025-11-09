---@type vim.lsp.Config
return {
  filetypes = { "arduino" },
  root_dir = function(bufnr, on_dir)
    on_dir(vim.fs.root(bufnr, function(name)
      return name:match "%.ino$" ~= nil
    end) or vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr)))
  end,
  cmd = {
    "arduino-language-server",
  },
  capabilities = {
    textDocument = {
      semanticTokens = vim.NIL,
    },
    workspace = {
      semanticTokens = vim.NIL,
    },
  },
}
