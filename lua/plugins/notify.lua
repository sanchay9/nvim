return {
  "rcarriga/nvim-notify",
  event = "VeryLazy",
  opts = {
    timeout = 1000,
    render = "minimal",
    max_height = function()
      return math.floor(vim.o.lines * 0.75)
    end,
    max_width = function()
      return math.floor(vim.o.columns * 0.75)
    end,
  },
  init = function()
    vim.notify = require "notify"
  end,
}
