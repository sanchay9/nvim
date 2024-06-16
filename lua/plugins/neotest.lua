return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-go",
    },
    -- stylua: ignore
    keys = {
      { "<leader>tt", function() require("neotest").run.run() end, desc = "Test Nearest" },
      { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Test File" },
      { "<leader>t.", function() require("neotest").run.run(vim.fn.expand("%:p:h")) end, desc = "Test Directory" },
      { "<leader>ta", function() require("neotest").run.run(vim.uv.cwd()) end, desc = "Test All" },
      { "<leader>ts", function() require("neotest").run.stop() end, desc = "Stop" },
      { "<leader>to", function() require("neotest").summary.toggle() end, desc = "Toggle Summary" },
      { "<leader>te", function() require("neotest").output.open({ enter = false, auto_close = true }) end, desc = "Show Output" },
      { "<leader>tp", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel" },
      { "[u", function() require("neotest").jump.prev() end, desc = "Prev test" },
      { "]u", function() require("neotest").jump.next() end, desc = "Next test" },
    },
    opts = {
      adapters = {
        ["neotest-go"] = {
          -- args = { "-tags=integration" }
          recursive_run = true,
        },
      },
      status = { virtual_text = false },
      output = { open_on_run = false },
      quickfix = {
        open = function()
          require("trouble").open { mode = "quickfix", focus = false }
        end,
      },
    },
    config = function(_, opts)
      local neotest_ns = vim.api.nvim_create_namespace "neotest"
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            -- Replace newline and tab characters with space for more compact diagnostics
            local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
          end,
        },
      }, neotest_ns)

      opts.consumers = opts.consumers or {}
      -- Refresh and auto close trouble after running tests
      ---@type neotest.Consumer
      opts.consumers.trouble = function(client)
        client.listeners.results = function(adapter_id, results, partial)
          if partial then
            return
          end
          local tree = assert(client:get_position(nil, { adapter = adapter_id }))

          local failed = 0
          for pos_id, result in pairs(results) do
            if result.status == "failed" and tree:get_key(pos_id) then
              failed = failed + 1
            end
          end
          vim.schedule(function()
            local trouble = require "trouble"
            if trouble.is_open() then
              trouble.refresh()
              if failed == 0 then
                trouble.close()
              end
            end
          end)
        end
        return {}
      end

      if opts.adapters then
        local adapters = {}
        for name, config in pairs(opts.adapters or {}) do
          if type(name) == "number" then
            if type(config) == "string" then
              config = require(config)
            end
            adapters[#adapters + 1] = config
          elseif config ~= false then
            local adapter = require(name)
            if type(config) == "table" and not vim.tbl_isempty(config) then
              local meta = getmetatable(adapter)
              if adapter.setup then
                adapter.setup(config)
              elseif meta and meta.__call then
                adapter(config)
              else
                error("Adapter " .. name .. " does not support setup")
              end
            end
            adapters[#adapters + 1] = adapter
          end
        end
        opts.adapters = adapters
      end

      require("neotest").setup(opts)
    end,
  },
}
