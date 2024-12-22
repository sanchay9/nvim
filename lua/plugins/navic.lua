return {
  {
    "SmiteshP/nvim-navic",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      highlight = true,
      depth_limit = 0,
      depth_limit_indicator = require("icons").misc.depth_indicator,
      safe_output = true,
    },
  },
}
