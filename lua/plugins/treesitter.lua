local _installed = nil ---@type table<string,boolean>?
local _queries = {} ---@type table<string,boolean>

local function get_installed(update)
  if update then
    _installed, _queries = {}, {}
    for _, lang in ipairs(require("nvim-treesitter").get_installed "parsers") do
      _installed[lang] = true
    end
  end
  return _installed or {}
end

local function have_query(lang, query)
  local key = lang .. ":" .. query
  if _queries[key] == nil then
    _queries[key] = vim.treesitter.query.get(lang, query) ~= nil
  end
  return _queries[key]
end

local function have(what, query)
  what = what or vim.api.nvim_get_current_buf()
  what = type(what) == "number" and vim.bo[what].filetype or what --[[@as string]]
  local lang = vim.treesitter.language.get_lang(what)
  if lang == nil or get_installed()[lang] == nil then
    return false
  end
  if query and not have_query(lang, query) then
    return false
  end
  return true
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    event = { "VeryLazy" },
    lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
    keys = {
      { "<c-space>", desc = "Increment Selection" },
      { "<c-bs>", desc = "Decrement Selection", mode = "x" },
    },
    opts_extend = { "ensure_installed" },
    ---@class lazyvim.TSConfig: TSConfig
    opts = {
      -- LazyVim config for treesitter
      indent = { enable = true },
      highlight = { enable = true },
      folds = { enable = true },
      ensure_installed = { "all" },
    },
    ---@param opts lazyvim.TSConfig
    config = function(_, opts)
      local TS = require "nvim-treesitter"

      -- setup treesitter
      TS.setup(opts)
      get_installed(true) -- initialize the installed langs

      -- install missing parsers
      local install = vim.tbl_filter(function(lang)
        return not have(lang)
      end, opts.ensure_installed or {})
      if #install > 0 then
        TS.install(install, { summary = true }):await(function()
          get_installed(true) -- refresh the installed langs
        end)
      end

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("lazyvim_treesitter", { clear = true }),
        callback = function(ev)
          if not have(ev.match) then
            return
          end

          -- highlighting
          if vim.tbl_get(opts, "highlight", "enable") ~= false then
            pcall(vim.treesitter.start)
          end

          -- -- indents
          -- if vim.tbl_get(opts, "indent", "enable") ~= false and LazyVim.treesitter.have(ev.match, "indents") then
          --   LazyVim.set_default("indentexpr", "v:lua.LazyVim.treesitter.indentexpr()")
          -- end
          --
          -- -- folds
          -- if vim.tbl_get(opts, "folds", "enable") ~= false and LazyVim.treesitter.have(ev.match, "folds") then
          --   if set_default("foldmethod", "expr") then
          --     set_default("foldexpr", "v:lua.LazyVim.treesitter.foldexpr()")
          --   end
          -- end
        end,
      })
    end,
  },

  -- config = function()
  --   require("nvim-treesitter.configs").setup {
  --     ensure_installed = "all",
  --     ignore_install = { "javascript" },
  --     highlight = {
  --       enable = true,
  --       disable = function(_, buf)
  --         local max_filesize = 100 * 1024 -- 100 KB
  --         local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
  --         if ok and stats and stats.size > max_filesize then
  --           return true
  --         end
  --       end,
  --     },
  --     indent = { enable = true },
  --     incremental_selection = {
  --       enable = true,
  --       keymaps = {
  --         init_selection = "<c-space>",
  --         node_incremental = "<c-space>",
  --         scope_incremental = false,
  --         node_decremental = "<c-bs>",
  --       },
  --     },
  --   }
  -- end,

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    after = "nvim-treesitter",
    opts = {
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        -- LazyVim extention to create buffer-local keymaps
        keys = {
          goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
          goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
          goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
          goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
        },
      },
    },
    -- textobjects = {
    --           select = {
    --             enable = true,
    --             lookahead = true,
    --             keymaps = {
    --               ["aa"] = "@parameter.outer",
    --               ["ia"] = "@parameter.inner",
    --               ["af"] = "@function.outer",
    --               ["if"] = "@function.inner",
    --               ["ac"] = "@class.outer",
    --               ["ic"] = "@class.inner",
    --             },
    --           },
    --           move = {
    --             enable = true,
    --             set_jumps = true,
    --             goto_next_start = {
    --               ["]m"] = "@function.outer",
    --               ["]o"] = "@class.outer",
    --             },
    --             goto_previous_start = {
    --               ["[m"] = "@function.outer",
    --               ["[o"] = "@class.outer",
    --             },
    --           },
    --           lsp_interop = {
    --             enable = true,
    --             border = "rounded",
    --             peek_definition_code = {
    --               ["<leader>k"] = "@function.outer",
    --             },
    --           },
    --         },
    config = function(_, opts)
      local TS = require "nvim-treesitter-textobjects"
      if not TS.setup then
        vim.notify("Please use `:Lazy` and update `nvim-treesitter`", vim.log.levels.ERROR)
        return
      end
      TS.setup(opts)

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("lazyvim_treesitter_textobjects", { clear = true }),
        callback = function(ev)
          if not (vim.tbl_get(opts, "move", "enable") and have(ev.match, "textobjects")) then
            return
          end
          ---@type table<string, table<string, string>>
          local moves = vim.tbl_get(opts, "move", "keys") or {}

          for method, keymaps in pairs(moves) do
            for key, query in pairs(keymaps) do
              local desc = query:gsub("@", ""):gsub("%..*", "")
              desc = desc:sub(1, 1):upper() .. desc:sub(2)
              desc = (key:sub(1, 1) == "[" and "Prev " or "Next ") .. desc
              desc = desc .. (key:sub(2, 2) == key:sub(2, 2):upper() and " End" or " Start")
              if not (vim.wo.diff and key:find "[cC]") then
                vim.keymap.set({ "n", "x", "o" }, key, function()
                  require("nvim-treesitter-textobjects.move")[method](query, "textobjects")
                end, {
                  buffer = ev.buf,
                  desc = desc,
                  silent = true,
                })
              end
            end
          end
        end,
      })
    end,
  },

  {
    "nvim-mini/mini.ai",
    event = "VeryLazy",
    opts = function()
      local ai = require "mini.ai"

      local function ai_buffer(ai_type)
        local start_line, end_line = 1, vim.fn.line "$"
        if ai_type == "i" then
          -- Skip first and last blank lines for `i` textobject
          local first_nonblank, last_nonblank = vim.fn.nextnonblank(start_line), vim.fn.prevnonblank(end_line)
          -- Do nothing for buffer with all blanks
          if first_nonblank == 0 or last_nonblank == 0 then
            return { from = { line = start_line, col = 1 } }
          end
          start_line, end_line = first_nonblank, last_nonblank
        end

        local to_col = math.max(vim.fn.getline(end_line):len(), 1)
        return { from = { line = start_line, col = 1 }, to = { line = end_line, col = to_col } }
      end

      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter { -- code block
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          },
          f = ai.gen_spec.treesitter { a = "@function.outer", i = "@function.inner" }, -- function
          c = ai.gen_spec.treesitter { a = "@class.outer", i = "@class.inner" }, -- class
          t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
          d = { "%f[%d]%d+" }, -- digits
          e = { -- Word with case
            { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
            "^().*()$",
          },
          g = ai_buffer, -- buffer
          u = ai.gen_spec.function_call(), -- u for "Usage"
          U = ai.gen_spec.function_call { name_pattern = "[%w_]" }, -- without dot in function name
        },
      }
    end,
    config = function(_, opts)
      require("mini.ai").setup(opts)
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    opts = {
      enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
      multiwindow = true, -- Enable multiwindow support.
      max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
      min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
      line_numbers = true,
      multiline_threshold = 20, -- Maximum number of lines to show for a single context
      trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
      mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
      -- Separator between context and content. Should be a single character string, like '-'.
      -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
      separator = nil,
      zindex = 20, -- The Z-index of the context window
      on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
    },
  },

  {
    "windwp/nvim-ts-autotag",
    after = "nvim-treesitter",
    opts = {},
  },
}
