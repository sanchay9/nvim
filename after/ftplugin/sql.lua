local M = {}

local cache_dir = vim.fn.stdpath "data" .. "/sql-runner"
local cache_file = cache_dir .. "/commands"

M.output_buf = nil
M.selected_command = nil

local function load_commands()
  if vim.fn.filereadable(cache_file) == 0 then
    return {}
  end

  local function file_exists(file)
    local f = io.open(file, "r")
    if f then
      f:close()
    end
    return f ~= nil
  end

  if not file_exists(cache_file) then
    return {}
  end

  local lines = {}
  for line in io.lines(cache_file) do
    lines[#lines + 1] = line
  end
  return lines
end

function M.run_sql()
  local function on_command_selected()
    if M.selected_command then
      vim.notify "hiii"
      M.run_query(M.selected_command)
    end
  end

  if M.selected_command then
    on_command_selected()
  else
    M.select_cmd(on_command_selected)
  end
end

function M.run_query(cmd)
  vim.api.nvim_input "<esc>"
  local line_s, line_e = vim.fn.getpos(".")[2], vim.fn.getpos("v")[2]
  if line_s > line_e then
    line_s, line_e = line_e, line_s
  end
  local lines = vim.api.nvim_buf_get_lines(0, line_s - 1, line_e, false)

  local query = ""
  for _, line in ipairs(lines) do
    query = string.format("%s%s\n", query, line)
  end

  M.get_output_buf()

  local cmd = { "psql", "-h", "hh-pgsql-public.ebi.ac.uk", "-U", "reader", "-d", "pfmegrnargs", "-c", query }
  -- vim.notify(cmd)
  -- local cmd = { cmd, "-c", query }

  local obj = vim.system(cmd, { text = true }):wait()
  local output = (obj.stderr ~= "" and obj.stderr .. "\n" or "") .. obj.stdout
  vim.api.nvim_buf_set_lines(M.output_buf, 0, -1, false, vim.split(output, "\n"))
end

function M.get_output_buf()
  if not M.output_buf or not vim.api.nvim_buf_is_valid(M.output_buf) then
    M.output_buf = vim.api.nvim_create_buf(false, true)

    vim.api.nvim_set_option_value("nu", false, {})
    vim.api.nvim_set_option_value("rnu", false, {})
  end

  -- Check if buffer is already visible in a window
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_buf(win) == M.output_buf then
      return
    end
  end
  vim.api.nvim_open_win(M.output_buf, false, { split = "right" })
end

vim.keymap.set("v", "<C-'>", function()
  vim.cmd "wa"
  M.run_sql()
end, { buffer = true })

function M.select_cmd(callback)
  local commands = load_commands()

  vim.ui.select(commands, { prompt = " sql: " }, function(selected)
    if selected then
      M.selected_command = selected
    end
  end)

  vim.notify "kjksdjf"
  if callback then
    callback()
  end
end

vim.keymap.set({ "n", "v" }, "<leader>re", M.select_cmd, { buffer = true })

return M
