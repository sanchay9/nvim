---@type vim.lsp.Config
return {
  filetypes = { "arduino" },
  root_markers = { ".git" },
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
