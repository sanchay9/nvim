local connections = {
  "psql -h cx-core-uat.cluster-c0iswfmnnzar.ap-south-1.rds.amazonaws.com -U cx -d cx",
  "psql -h cx-core-cug.cluster-c0iswfmnnzar.ap-south-1.rds.amazonaws.com -U cx -d cx",
  "psql -h cx-core-prod.cluster-c0iswfmnnzar.ap-south-1.rds.amazonaws.com -U cx -d cx",
}

vim.g.sql_connection = connections[1]
local output_buf

local function get_output_buf()
  if not output_buf or not vim.api.nvim_buf_is_valid(output_buf) then
    output_buf = vim.api.nvim_create_buf(false, true)
  end
  return output_buf
end

local function show_output_win(buf)
  -- Check if buffer is already visible in a window
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_buf(win) == buf then
      return
    end
  end
  vim.api.nvim_open_win(buf, false, { split = "right" })
end

vim.keymap.set("v", "<C-'>", function()
  if vim.api.nvim_get_mode().mode ~= "V" then
    return
  end

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

  local buf = get_output_buf()
  show_output_win(buf)

  local cmd = string.format('%s -c "%s"', vim.g.sql_connection, query)
  vim.fn.jobstart(cmd, {
    on_stdout = function(_, data)
      if data and #data > 0 then
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, data)
        vim.notify(vim.inspect(data), vim.log.levels.INFO, { title = "SQL Output" })
      end
    end,
    on_stderr = function(_, data)
      if data and #data > 0 then
        for _, line in ipairs(data) do
          vim.api.nvim_buf_set_lines(buf, -1, -1, false, { line })
        end
      end
    end,
  })
end, { buffer = true })

vim.keymap.set("n", "<leader>re", function()
  vim.ui.select(connections, { prompt = "sql: " }, function(selected)
    if selected then
      vim.g.sql_connection = selected
    end
  end)
end, { buffer = true })
