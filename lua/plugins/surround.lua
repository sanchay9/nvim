return {
  "echasnovski/mini.surround",
  keys = {
    { "gsa", desc = "Add Surrounding", mode = { "n", "v" } },
    { "gsd", desc = "Delete Surrounding" },
    { "gsf", desc = "Find Right Surrounding" },
    { "gsF", desc = "Find Left Surrounding" },
    { "gsh", desc = "Highlight Surrounding" },
    { "gsr", desc = "Replace Surrounding" },
    { "gsn", desc = "Update `MiniSurround.config.n_lines`" },
  },
  opts = {
    mappings = {
      add = "gsa",
      delete = "gsd",
      find = "gsf",
      find_left = "gsF",
      highlight = "gsh",
      replace = "gsr",
      update_n_lines = "gsn",
    },
  },
}
