return {
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    config = function()
      local db = require "alpha.themes.dashboard"
      local stats = require("lazy").stats()

      db.section.header.opts.hl = "AlphaHeader"
      db.section.footer.opts.hl = "AlphaFooter"

      -- local term_height = 10
      -- require "alpha.term"
      -- db.section.header = {
      --     type = "terminal",
      --     -- command = "cat | lolcat -F 0.3 " .. os.getenv("HOME") .. "/.config/nvim/lua/banners/neovim.cat",
      --     command = "neo --fps=20 --speed=5 -D -m 'NEO VIM' -d 0.5 -l 1,1",
      --     width = 60,
      --     height = term_height,
      --     opts = {
      --         redraw = true,
      --         window_config = {},
      --     },
      -- }
      db.section.header.val = require("banners")["vim"]
      -- db.section.footer.val = require("alpha.fortune")
      -- db.section.footer.val = "  Neovim loaded " .. require("lazy").stats().count .. " plugins"

      db.section.footer.val = {
        -- "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. (math.floor(
        --     stats.startuptime * 100 + 0.5
        -- ) / 100) .. "ms",
        os.date "  %d/%m/%Y "
          .. "  "
          .. stats.count
          .. " plugins "
          .. "  v"
          .. vim.version().major
          .. "."
          .. vim.version().minor
          .. "."
          .. vim.version().patch,
      }

      db.section.buttons.val = {
        -- db.button( 'p',   '  Practice',    ":cd ~/code | e A.cpp<CR>" ),
        db.button("w", "  Notes", ":cd ~/docs/notes | e index.md <CR><CR>"),
        db.button("r", "  Recents", ":Telescope oldfiles<CR>"),
        db.button("c", "  Config", ":cd ~/.config/nvim | Telescope fd<CR>"),
        -- db.button( 't',   '  Theme',       ":Telescope colorscheme_live<CR>" ),
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

      -- local status_ok, alpha = pcall(require, "alpha")
      -- local dashboard = require("alpha.themes.dashboard")

      -- if not status_ok then
      -- 	return
      -- end

      -- -- Function to retrieve console output
      -- local function capture(cmd)
      --   local handle = assert(io.popen(cmd, 'r'))
      --   local output = assert(handle:read('*a'))
      --   handle:close()
      --   return output
      -- end

      -- local function button(sc, txt, keybind, keybind_opts)
      --   local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

      --   local opts = {
      --     position = "center",
      --     shortcut = sc,
      --     cursor = 5,
      --     width = 30,
      --     align_shortcut = "right",
      --     hl_shortcut = "Keyword",
      --   }

      --   if keybind then
      --     keybind_opts = vim.F.if_nil(keybind_opts, {noremap = true, silent = true, nowait = true})
      --     opts.keymap = {"n", sc_, keybind, keybind_opts}
      --   end

      --   local function on_press()
      --     local key = vim.api.nvim_replace_termcodes(sc_ .. '<Ignore>', true, false, true)
      --     vim.api.nvim_feedkeys(key, "normal", false)
      --   end

      --   return {
      --     type = "button",
      --     val = txt,
      --     on_press = on_press,
      --     opts = opts,
      --   }
      -- end

      -- -- Obtain Date Info
      -- local date = io.popen('echo "$(date +%a) $(date +%d) $(date +%b)" | tr -d "\n"')
      -- local date_info = "󰨲 Today is " .. date:read("*a")
      -- date:close()

      -- -- Configuration
      -- Header = {
      -- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠋⣀⣀⣤⣤⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      -- "⣿⣿⣿⣿⣿⣿⣿⣿⢟⢍⣼⣿⣿⣿⣿⣿⡝⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      -- "⣿⣿⣿⣿⣿⣿⢟⣵⢏⣾⣿⣿⣿⣷⣿⣟⣤⠀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      -- "⣿⣿⣿⣿⣿⣫⡿⠋⠀⢻⣿⣿⣿⡿⠿⢸⠏⠠⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      -- "⣿⣿⣿⣿⢣⠟⠀⠀⠀⠀⠙⠟⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      -- "⣿⣿⣿⣿⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡇⠀⠀⠀⠀⠀⠀⠀⠀⢠⡀⠀⠀⠀⠀",
      -- "⣿⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⣿⣿⡀⠀⠀⠀⠀⠀⠀⠀⣸⣧⠀⠀⠀⠀",
      -- "⣿⠻⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⢀⠈⠉⠑⠀⠀⢀⠀⠀⠀⡄⢩⣿⣧⡀⣖⢋",
      -- "⣿⣷⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⡦⡜⣤⢸⣦⣸⣦⡀⠀⢸⡆⠀⡀⠀⢈⠀",
      -- "⣿⣿⠁⠀⠀⣴⡆⠀⠀⠀⠀⢀⠀⣻⣿⣿⣽⣿⣿⣿⣿⣿⣷⣾⣧⢦⣵⣄⣿⠀",
      -- "⣿⣿⡄⣰⣬⣿⣇⠀⠀⠀⠀⢸⠀⢹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠃⠀",
      -- "⣯⣝⣷⣿⡿⢻⣿⡄⠀⠀⢸⣦⠀⠀⡹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠃⠀",
      -- "⣿⣿⢯⣶⣿⣿⣿⣿⣦⣀⠘⢿⢨⡆⡜⣶⡝⠿⣿⣿⣿⣿⣿⣿⡿⠟⠋⠁⣀⣠",
      -- "⣽⣯⣾⣿⣿⣿⡿⠛⠿⠿⠿⠒⠻⠓⢚⢘⣴⣿⡬⣝⣛⣻⣽⣶⣏⡄⢸⣿⠋⡟",
      -- }

      -- -- Config gif header
      -- require("alpha.term")

      -- local dynamic_header = {
      --   type = "terminal",
      --   command = "chafa -c full --fg-only --symbols braille ~/dls/db.gif",
      --   width = 90,
      --   height = 20,
      --   opts = {
      --     position = "center",
      --     redraw = true,
      --     window_config = {},
      --   },
      -- }

      -- local text_header = {
      --   type = "text",
      --   val = Header,
      --   opts = {
      --     position = "center",
      --     hl = "Type",
      --   }
      -- }

      -- --[[ local default_header = nil
      -- local ret = "command -v chafa"

      -- if ret == 0
      --   default_header = dynamic_header
      -- else
      --   default_header = text_header ]]

      -- local date_today = {
      --   type = "text",
      --   val = date_info,
      --   opts= {
      --     position = "center",
      --     hl = "Keyword",
      --   },
      -- }

      -- local buttons = {
      --   type = "group",
      --   val = {
      --     button("f", " -> Find file", ":Telescope find_files <CR>"),
      --     -- button("e", " -> New file", ":ene <BAR> startinsert <CR>"),
      --     button("e", " -> New file", ":RnvimrToggle <CR>"),
      --     button("p", " -> Find project", ":Telescope projects <CR>"),
      --    -- button("r", " -> Recently used files", ":Telescope oldfiles <CR>"),
      --    -- button("t", " -> Find text", ":Telescope live_grep <CR>"),
      --     button("c", " -> Configuration", ":e ~/.config/nvim/init.lua <CR>"),
      --     button("q", " -> Quit Neovim", ":qa<CR>"),
      --   },
      --   opts = {
      --     spacing = 1,
      --   }
      -- }

      -- --[[ local plugins_str = "- Neovim with plugins installed -" ]]

      -- local footer = {
      --   type = "text",
      --   -- val = fortune(),
      --   val = "- Neovim with " .. "44" .. " 󰚥 installed -",
      --   opts = {
      --     position = "center",
      --     hl = "Number",
      --   },
      -- }

      -- local section = {
      --   header = dynamic_header,
      --   date = date_today,
      --   buttons = buttons,
      --   footer = footer,
      -- }

      -- local opts = {
      --   layout = {
      --     { type = "padding", val = 5 },
      --     section.header,
      --     { type = "padding", val = 18 },
      --     section.date,
      --     { type = "padding", val = 2 },
      --     section.buttons,
      --     { type = "padding", val = 1 },
      --     section.footer,
      --     { type = "padding", val = 5 },
      --   },
      --   opts = {
      --     margin = 5,
      --     noautocmd = true,
      --     redraw_on_resize = true,
      --   },
      -- }

      -- dashboard.opts = opts
      -- alpha.setup(dashboard.opts)
    end,
  },
}
