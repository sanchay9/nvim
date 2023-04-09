-- All plugins have lazy=true by default,to load a plugin on startup just lazy=false
-- List of all default plugins & their definitions
local default_plugins = {

    "nvim-lua/plenary.nvim",

    {
        "RRethy/vim-illuminate",
        lazy = false,
        config = function()
            require('illuminate').configure {
                filetypes_denylist = {
                    "dirvish",
                    "fugitive",
                    "alpha",
                    "NvimTree",
                    "lazy",
                    "neogitstatus",
                    "Trouble",
                    "lir",
                    "Outline",
                    "spectre_panel",
                    "toggleterm",
                    "DressingSelect",
                    "TelescopePrompt",
                },
            }
        end
    },

    {
        "sanchay9/base46",
        build = function()
            require"colors".init()
        end,
    },

    {
        "goolord/alpha-nvim",
        lazy = false,
        -- event = "VimEnter",
        config = function()
            require "plugins.configs.alpha"
        end,
    },

    {
        "akinsho/bufferline.nvim",
        lazy = false,
        config = function()
            -- dofile(vim.g.base46_cache .. "bufferline")
            require "plugins.configs.bufferline"
        end,
    },

    {
        "NvChad/nvim-colorizer.lua",
        init = function()
            require("core.utils").lazy_load "nvim-colorizer.lua"
        end,
        config = function()
            require("colorizer").setup { filetypes = {
                '*'; -- Highlight all files, but customize some others.
                '!NvimTree'; -- Exclude NvimTree from highlighting.
            }}

            -- execute colorizer as soon as possible
            vim.defer_fn(function()
                require("colorizer").attach_to_buffer(0)
            end, 0)
        end,
    },

    {
        "nvim-tree/nvim-web-devicons",
        opts = function()
            return { override = require("plugins.configs.icons").devicons }
        end,
        config = function(_, opts)
            dofile(vim.g.base46_cache .. "devicons")
            require("nvim-web-devicons").setup(opts)
        end,
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        init = function()
            require("core.utils").lazy_load "indent-blankline.nvim"
        end,
        config = function()
            dofile(vim.g.base46_cache .. "blankline")
            require "plugins.configs.indentline"
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        init = function()
            require("core.utils").lazy_load "nvim-treesitter"
        end,
        cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
        build = ":TSUpdate",
        config = function()
            dofile(vim.g.base46_cache .. "syntax")
            require "plugins.configs.treesitter"
        end,
    },

    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        after = 'nvim-treesitter',
    },

    {
        "windwp/nvim-ts-autotag",
    },

    {
        "lewis6991/gitsigns.nvim",
        ft = "gitcommit",
        init = function()
            -- load gitsigns only when a git file is opened
            vim.api.nvim_create_autocmd({ "BufRead" }, {
                group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
                callback = function()
                    vim.fn.system("git -C " .. '"' .. vim.fn.expand "%:p:h" .. '"' .. " rev-parse")
                    if vim.v.shell_error == 0 then
                        vim.api.nvim_del_augroup_by_name "GitSignsLazyLoad"
                        vim.schedule(function()
                            require("lazy").load { plugins = { "gitsigns.nvim" } }
                        end)
                    end
                end,
            })
        end,
        config = function()
            dofile(vim.g.base46_cache .. "git")
            require "plugins.configs.gitsigns"
        end,
    },

    {
        "williamboman/mason.nvim",
        cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
        config = function()
            dofile(vim.g.base46_cache .. "mason")
            require "plugins.configs.mason"
        end,
    },

    {
        "neovim/nvim-lspconfig",
        init = function()
            require("core.utils").lazy_load "nvim-lspconfig"
        end,
        config = function()
            dofile(vim.g.base46_cache .. "lsp")
            require "plugins.configs.lspconfig"
        end,
    },

    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            {
                "L3MON4D3/LuaSnip",
                config = function()
                    require "plugins.configs.luasnip"
                end,
            },

            {
                "windwp/nvim-autopairs",
                config = function()
                    require "plugins.configs.autopairs"
                end,
            },

            {
                "saadparwaiz1/cmp_luasnip",
                "hrsh7th/cmp-nvim-lua",
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
            },
        },

        config = function()
            dofile(vim.g.base46_cache .. "cmp")
            require "plugins.configs.cmp"
        end,
    },

    {
        "numToStr/Comment.nvim",
        -- keys = { "gc", "gb" },
        lazy = false,
        config = function()
            require("Comment").setup {
                ignore = '^$',
                mappings = {
                    extra = false,
                },
            }
        end,
    },

    {
        "nvim-tree/nvim-tree.lua",
        cmd = { "NvimTreeToggle", "NvimTreeFocus" },
        config = function()
            dofile(vim.g.base46_cache .. "nvimtree")
            require "plugins.configs.nvimtree"
        end,
    },

    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        dependencies = {
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            "dhruvmanila/telescope-bookmarks.nvim",
            "nvim-telescope/telescope-symbols.nvim",
            "nvim-telescope/telescope-project.nvim",
            "nvim-telescope/telescope-file-browser.nvim",
        },
        config = function()
            dofile(vim.g.base46_cache .. "telescope")
            require "plugins.configs.telescope"
        end,
    },

    {
        "akinsho/toggleterm.nvim",
        cmd = "TermExec",
        config = function()
            require "plugins.configs.toggleterm"
        end,
    },

    {
        "SmiteshP/nvim-navic",
        config = function()
            require "plugins.configs.navic"
        end,
    },

    {
        "kylechui/nvim-surround",
        lazy = false,
        config = function()
            require("nvim-surround").setup({
            })
        end
    },

    {
        "mbbill/undotree",
        cmd = "UndotreeToggle",
        config = function()
            vim.g.undotree_SetFocusWhenToggle = 1
        end
    },

    {
        "wfxr/minimap.vim",
        cmd = "MinimapToggle",
        config = function()
            vim.g.minimap_width = 14
            vim.g.minimap_git_colors = 1
        end
    },

    {
        "iamcco/markdown-preview.nvim",
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
    },

    {
        "iamcco/markdown-preview.nvim",
        build = "cd app && npm install",
        init = function()
            -- vim.g.mkdp_browser = "google-chrome-beta --new-window --app"
            vim.g.mkdp_port = '8090'
            -- vim.g.mkdp_theme = 'dark'

            vim.cmd[[
            function OpenMarkdownPreview (url)
                execute "silent ! google-chrome-beta --new-window --app=" . a:url
            endfunction

            let g:mkdp_browserfunc = 'OpenMarkdownPreview'
            ]]
            -- vim.g.mkdp_browserfunc = function(url)
            --     -- vim.notify(url)
            --     vim.cmd[[execute "silent ! firefox --new-window " . a:url]]
            --     -- vim.cmd("silent ! google-chrome-beta --new-window --app=" .. url)
            -- end
        end,
        ft = { "markdown" },
    },

    {
        "dstein64/vim-startuptime",
        cmd = "StartupTime"
    },

    --  {
    --     "karb94/neoscroll.nvim",
    --     config = function()
    --         require('neoscroll').setup()
    --     end
    -- },

    -- {
    --     "ray-x/lsp_signature.nvim",
    --     -- after = "nvim-lspconfig",
    --     config = function()
    --         local present, lspsignature = pcall(require, "lsp_signature")

    --         if not present then
    --             return
    --         end

    --         lspsignature.setup {
    --             bind = true,
    --             doc_lines = 0,
    --             floating_window = false,
    --             fix_pos = true,
    --             hint_enable = true,
    --             hint_prefix = " ",
    --             -- hint_scheme = "String",
    --             hint_scheme = "Comment",
    --             hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
    --             max_height = 22,
    --             max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
    --             handler_opts = {
    --                 border = "none",
    --             },
    --             zindex = 200, -- by default it will be on top of all floating windows, set to 50 send it to bottom
    --             padding = "", -- character to pad on left and right of signature can be ' ', or '|'  etc
    --         }
    --     end
    -- },
    -- {
    --     "vimwiki/vimwiki",
    --     cmd = "VimwikiIndex",
    -- },
}

require("lazy").setup(default_plugins, {
    defaults = { lazy = true },
    performance = {
        rtp = {
            disabled_plugins = {
                "2html_plugin",
                "tohtml",
                "getscript",
                "getscriptPlugin",
                "gzip",
                "logipat",
                "netrw",
                "netrwPlugin",
                "netrwSettings",
                "netrwFileHandlers",
                "matchit",
                "tar",
                "tarPlugin",
                "rrhelper",
                "spellfile_plugin",
                "vimball",
                "vimballPlugin",
                "zip",
                "zipPlugin",
                "tutor",
                "rplugin",
                "syntax",
                "synmenu",
                "optwin",
                "compiler",
                "bugreport",
                "ftplugin",
            },
        },
    },
})
