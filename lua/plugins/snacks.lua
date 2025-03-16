-- TODO: Snacks.toggle.zoom():map "<leader>f"

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    quickfile = { enabled = true },
    words = { enabled = true },
    notifier = { enabled = true },
    statuscolumn = { enabled = true },
    image = { enabled = true },
    indent = {
      enabled = true,
      indent = {
        char = "▏", -- '▏', '┊', '|', '¦', '┆'
      },
      filter = function(buf)
        return vim.g.snacks_indent ~= false
          and vim.b[buf].snacks_indent ~= false
          and vim.bo[buf].buftype == ""
          and vim.bo[buf].filetype ~= "http"
      end,
      scope = {
        enabled = true,
        priority = 200,
        char = "▏", -- '▏', '┊', '|', '¦', '┆'
        underline = true,
        only_current = true,
      },
    },
  },
  -- stylua: ignore
  keys = {
    { "]]", function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" }, },
    { "[[", function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" }, },
    { "<leader>gx", function() Snacks.gitbrowse() end, desc = "Git Browse", },
    { "<leader>`", function() Snacks.notifier.show_history() end, desc = "Notification History" },
  },
}
