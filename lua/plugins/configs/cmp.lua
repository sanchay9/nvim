local cmp = require "cmp"

local cmp_ui = require("core.utils").load_config().ui.cmp
local cmp_style = cmp_ui.style

local field_arrangement = {
    atom = { "kind", "abbr", "menu" },
    atom_colored = { "kind", "abbr", "menu" },
}

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local function border(hl_name)
    return {
        { "╭", hl_name },
        { "─", hl_name },
        { "╮", hl_name },
        { "│", hl_name },
        { "╯", hl_name },
        { "─", hl_name },
        { "╰", hl_name },
        { "│", hl_name },
    }
end

local options = {
    completion = {
        completeopt = "menu,menuone",
    },

    window = {
        completion = {
            side_padding = (cmp_style ~= "atom" and cmp_style ~= "atom_colored") and 1 or 0,
            winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:PmenuSel",
            scrollbar = false,
        },
        documentation = {
            border = border "CmpDocBorder",
            winhighlight = "Normal:CmpDoc",
        },
    },
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },

    formatting = {
        -- default fields order i.e completion word + item.kind + item.kind icons
        fields = field_arrangement[cmp_style] or { "abbr", "kind", "menu" },

        format = function(_, item)
            local icons = require "plugins.configs.icons".lspkind

            local icon = (cmp_ui.icons and icons[item.kind]) or ""

            if cmp_style == "atom" or cmp_style == "atom_colored" then
                icon = " " .. icon .. " "
                item.menu = cmp_ui.lspkind_text and "   (" .. item.kind .. ")" or ""
                item.kind = icon
            else
                icon = cmp_ui.lspkind_text and (" " .. icon .. " ") or icon
                item.kind = string.format("%s %s", icon, cmp_ui.lspkind_text and item.kind or "")
            end

            return item
        end,
    },
    -- formatting = {
    --     format = function(entry, vim_item)
    --         vim_item.abbr = string.sub(vim_item.abbr, 1, 30)
    --         vim_item.kind = string.format("%s", lspkind_icons[vim_item.kind])
    --         -- vim_item.kind = string.format("%s %s", lspkind_icons[vim_item.kind], vim_item.kind)

    --         -- show source
    --         vim_item.menu = ({
    --             nvim_lsp = "[LSP]",
    --             nvim_lua = "[Lua]",
    --             luasnip = "[Snippet]",
    --             buffer = "[Buffer]",
    --             path = "[Path]",
    --         })[entry.source.name]
    --         return vim_item
    --     end,
    -- },
    -- -- vscode
    -- formatting = {
    --     fields = { "kind", "abbr" },
    --     format = function(_, vim_item)
    --         vim_item.abbr = string.sub(vim_item.abbr, 1, 30)
    --         vim_item.kind = lspkind_icons[vim_item.kind] or ""
    --         return vim_item
    --     end,
    -- },

    mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
        },
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif require("luasnip").expand_or_jumpable() then
                require("luasnip").expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif require("luasnip").jumpable(-1) then
                require("luasnip").jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "nvim_lua" },
        { name = "path" },
    },
    experimental = {
        ghost_text = true,
    },
}

if cmp_style ~= "atom" and cmp_style ~= "atom_colored" then
    options.window.completion.border = border "CmpBorder"
end

cmp.setup(options)
