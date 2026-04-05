vim.filetype.add {
  pattern = {
    [".*"] = function(path, bufnr)
      return vim.bo[bufnr]
          and vim.bo[bufnr].filetype ~= "bigfile"
          and path
          and vim.fn.getfsize(path) > (1024 * 500) -- 500 KB
          and "bigfile"
        or nil
    end,
  },
}
