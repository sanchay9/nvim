---@type vim.lsp.Config
return {
  cmd = { "gopls", "serve" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_markers = { "go.mod", "go.work" },
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
}
