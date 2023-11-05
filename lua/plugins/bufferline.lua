return {
  {
    "akinsho/bufferline.nvim",
    enabled = false,
    keys = {
      { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Goto Prev Buffer" },
      { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Goto Next Buffer" },
    },
    event = "VeryLazy",
    config = function()
      require("bufferline").setup {
        options = {
          offsets = {
            { filetype = "NvimTree", text = "", padding = 1 },
            { filetype = "undotree", text = "", padding = 1 },
          },
          buffer_close_icon = "",
          mode = "buffers",
          modified_icon = "",
          close_icon = "",
          show_close_icon = false,
          left_trunc_marker = " ",
          right_trunc_marker = " ",
          max_name_length = 14,
          max_prefix_length = 13,
          tab_size = 18,
          indicator_icon = " ",
          show_tab_indicators = true,
          enforce_regular_tabs = false,
          view = "multiwindow",
          show_buffer_close_icons = true,
          separator_style = "thin",
          always_show_bufferline = false,
          diagnostics = false,
          themable = true,
          custom_areas = {
            right = function()
              vim.cmd [[
                function! Quit_vim(a,b,c,d)
                    qa
                endfunction
              ]]

              return {
                { text = "%@Quit_vim@  %X" },
              }
            end,
          },
          custom_filter = function(buf)
            local filetypes = { "vimwiki", "awk", "help", "zsh" }
            local buftypes = { "terminal" }

            for _, ft in ipairs(filetypes) do
              if vim.bo[buf].filetype == ft then
                return false
              end
            end
            for _, bt in ipairs(buftypes) do
              if vim.bo[buf].buftype == bt then
                return false
              end
            end
            return true
          end,
        },
      }
    end,
  },
}
