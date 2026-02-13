local M = _G.__sql_runner or {}
_G.__sql_runner = M

local icons = require("icons").status
local connections_file = vim.fn.expand "%:p:h" .. "/.connections"

local ns_id = vim.api.nvim_create_namespace "sql-runner"

M.output_buf = M.output_buf or nil
M.output_win = M.output_win or nil
M.selected_connection = M.selected_connection or nil

local function load_connections()
  if vim.fn.filereadable(connections_file) == 0 then
    return {}
  end

  local connections = {}
  for line in io.lines(connections_file) do
    local alias, conn_string = line:match "^([^|]+)|(.+)$"
    if alias and conn_string then
      connections[#connections + 1] = {
        alias = alias,
        connection_string = conn_string,
      }
    end
  end
  return connections
end

local function ensure_output_win()
  -- Create buffer if needed
  if not M.output_buf or not vim.api.nvim_buf_is_valid(M.output_buf) then
    M.output_buf = vim.api.nvim_create_buf(false, true)
    vim.bo[M.output_buf].buftype = "nofile"
    vim.bo[M.output_buf].bufhidden = "hide"
    vim.bo[M.output_buf].swapfile = false
  end

  -- Check if window exists and is valid
  if M.output_win and vim.api.nvim_win_is_valid(M.output_win) then
    return
  end

  -- Find existing window showing this buffer
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_buf(win) == M.output_buf then
      M.output_win = win
      return
    end
  end

  -- Create new window
  M.output_win = vim.api.nvim_open_win(M.output_buf, false, { split = "right" })
  vim.wo[M.output_win].number = false
  vim.wo[M.output_win].relativenumber = false
  vim.wo[M.output_win].wrap = false
  vim.wo[M.output_win].cursorline = false
  vim.wo[M.output_win].list = false
end

local function set_output(text)
  if not M.output_buf or not vim.api.nvim_buf_is_valid(M.output_buf) then
    return
  end

  local lines = vim.split(text, "\n", { plain = true, trimempty = false })
  table.insert(lines, 1, "")
  vim.api.nvim_buf_set_lines(M.output_buf, 0, -1, false, lines)

  -- Scroll to top
  if M.output_win and vim.api.nvim_win_is_valid(M.output_win) then
    vim.api.nvim_win_set_cursor(M.output_win, { 1, 0 })
  end
end

local function set_status(src_buf, line, icon, hl)
  vim.api.nvim_buf_clear_namespace(src_buf, ns_id, 0, -1)

  if icon then
    vim.api.nvim_buf_set_extmark(src_buf, ns_id, line - 1, 0, {
      sign_text = icon,
      sign_hl_group = hl,
    })
  end
end

local function get_visual_lines()
  local mode = vim.fn.mode()
  -- Only work in linewise visual mode
  if mode ~= "V" then
    return nil, nil
  end

  local cursor = vim.fn.getpos "."
  local vstart = vim.fn.getpos "v"
  local line_s, line_e = cursor[2], vstart[2]
  if line_s > line_e then
    line_s, line_e = line_e, line_s
  end
  return line_s, line_e
end

function M.run_query(line_s, line_e, src_buf)
  local lines = vim.api.nvim_buf_get_lines(src_buf, line_s - 1, line_e, false)
  local query = table.concat(lines, "\n")

  ensure_output_win()
  set_status(src_buf, line_s, icons.loading, "DiagnosticInfo")

  if not M.selected_connection or not M.selected_connection.connection_string then
    set_status(src_buf, line_s, icons.error, "DiagnosticError")
    set_output "No connection selected"
    return
  end

  local shell_cmd = {}
  for arg in M.selected_connection.connection_string:gmatch "%S+" do
    shell_cmd[#shell_cmd + 1] = arg
  end
  shell_cmd[#shell_cmd + 1] = "-c"
  shell_cmd[#shell_cmd + 1] = query

  vim.system(shell_cmd, { text = true }, function(obj)
    vim.schedule(function()
      local has_error = obj.stderr and obj.stderr ~= ""
      if has_error then
        set_status(src_buf, line_s, icons.error, "DiagnosticError")
      else
        set_status(src_buf, line_s, icons.done, "DiagnosticOk")
      end

      local output = ""
      if has_error then
        output = obj.stderr .. "\n"
      end
      if obj.stdout then
        output = output .. obj.stdout
      end
      set_output(output)
    end)
  end)
end

function M.run_sql()
  local src_buf = vim.api.nvim_get_current_buf()
  local line_s, line_e = get_visual_lines()

  if not line_s then
    vim.notify("Select lines with V (linewise visual)", vim.log.levels.WARN)
    return
  end

  -- Exit visual mode
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "nx", false)

  if M.selected_connection then
    M.run_query(line_s, line_e, src_buf)
  else
    M.select_connection(function()
      M.run_query(line_s, line_e, src_buf)
    end)
  end
end

function M.select_connection(callback)
  local connections = load_connections()
  if #connections == 0 then
    vim.notify("No connections found in .connections file", vim.log.levels.ERROR)
    return
  end

  local aliases = {}
  for _, conn in ipairs(connections) do
    aliases[#aliases + 1] = conn.alias
  end

  vim.ui.select(aliases, { prompt = " sql: " }, function(selected)
    if selected then
      for _, conn in ipairs(connections) do
        if conn.alias == selected then
          M.selected_connection = conn
          break
        end
      end
      if callback then
        callback()
      end
    end
  end)
end

vim.keymap.set("x", "<C-'>", function()
  vim.cmd "wa"
  M.run_sql()
end, { buffer = true })

vim.keymap.set({ "n", "v" }, "<leader>re", M.select_connection, { buffer = true })

return M
