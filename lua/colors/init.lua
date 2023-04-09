vim.g.curr_theme = "tokyonight"

local M = {}

M.init = function(theme)
    if not theme then
        theme = vim.g.curr_theme
    else
        vim.g.curr_theme = theme
    end

    require"base46".load_all_highlights()
end

M.get = function(theme)
    if not theme then
        theme = vim.g.curr_theme
    end

    return require("base46.themes." .. theme).base_30
end

return M
