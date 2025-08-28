return {
  -- dailies date_format = "%Y-%m-%d", alias_format = "%B %-d, %Y",
  -- note_id_func = function(title)
  --   local suffix = ""
  --   if title ~= nil then
  --     -- If title is given, transform it into valid file name.
  --     suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
  --   else
  --     return ""
  --   end
  --   return tostring(os.date "%Y%m%d") .. "-" .. suffix
  -- end,

  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "copilot-chat", "codecompanion" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-mini/mini.icons",
    },
    opts = {
      file_types = { "markdown", "copilot-chat", "codecompanion" },
      code = {
        sign = false,
        width = "block",
        right_pad = 1,
      },
      heading = {
        -- bullets: • external link
        icons = { "◉ ", "○ ", "✸ ", "✿ " },
      },
    },
  },

  {
    "iamcco/markdown-preview.nvim",
    cmd = "MarkdownPreviewToggle",
    build = function()
      require("lazy").load { plugins = { "markdown-preview.nvim" } }
      vim.fn["mkdp#util#install"]()
    end,
    keys = { { "<leader>D", ft = "markdown", "<cmd>MarkdownPreviewToggle<cr>", desc = "markdown preview" } },
    config = function()
      vim.cmd "do FileType"
    end,
  },
}
