return {
  {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VimEnter",
    config = function()
      local db = require "alpha.themes.dashboard"
      local stats = require("lazy").stats()

      db.section.header.opts.hl = "AlphaHeader"
      db.section.footer.opts.hl = "AlphaFooter"

      -- local term_height = 10
      -- require "alpha.term"
      -- db.section.header = {
      --   type = "terminal",
      --   command = "neo --fps=20 --speed=5 -D -m 'NEO VIM' -d 0.5 -l 1,1",
      --   width = 60,
      --   height = term_height,
      --   opts = {
      --     redraw = true,
      --     window_config = {},
      --   },
      -- }
      db.section.header.val = require("banners")["vim"]

      -- db.section.footer.val = require "alpha.fortune"
      db.section.footer.val = {
        "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. stats.startuptime .. "ms",
        -- vim
        --   .system({
        --     "curl",
        --     "https://vtip.43z.one",
        --   })
        --   :wait().stdout,
      }

      db.section.buttons.val = {
        db.button("w", "  Notes", "<cmd>cd ~/docs/notes | e index.md<cr>"),
        db.button("r", "  Recents", "<cmd>Telescope oldfiles<cr>"),
        db.button("c", "  Config", "<cmd>cd ~/.config/nvim | Telescope find_files<cr>"),
      }

      db.config.layout = {
        { type = "padding", val = 6 },
        db.section.header,
        -- { type = "padding", val = term_height + 7 },
        { type = "padding", val = 2 },
        db.section.buttons,
        { type = "padding", val = 2 },
        db.section.footer,
      }

      require("alpha").setup(db.opts)
    end,
  },
}
