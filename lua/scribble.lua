-- local width = math.floor(vim.o.columns * 0.5)
-- local height = math.floor(vim.o.lines * 0.9)

-- local bufnr = vim.fn.bufadd("/home/sanchay/a.sh")
-- vim.api.nvim_open_win(bufnr, true, {
--     -- style = "minimal",
--     relative = "editor",
--     row = math.floor(((vim.o.lines - height) / 2) - 1),
--     col = math.floor(vim.o.columns - width - 1),
--     width = width,
--     height = height,
-- })

-- vim.api.nvim_buf_set_option(bufnr, "modifiable", false)

-- vim.api.nvim_buf_set_keymap(bufnr, "n", "q", "<cmd>bunload<CR>", { noremap = true })

-- local self = setmetatable({}, { __index = {} })

-- local toggle = function ()
--   if self.win and vim.api.nvim_win_is_valid(self.win) then
--     self:hide()
--     return false
--   else
--     self:show()
--     return true
--   end
-- end
--
--
--
--
local notepad_loaded = false
local notepad_buf, notepad_win = nil, nil
local function launch_notepad()
	if not notepad_loaded or not vim.api.nvim_win_is_valid(notepad_win) then
		if not notepad_buf or not vim.api.nvim_buf_is_valid(notepad_buf) then
			-- Create a buffer if it none existed
			notepad_buf = vim.api.nvim_create_buf(false, true)
			vim.api.nvim_buf_set_option(notepad_buf, "bufhidden", "hide")
			vim.api.nvim_buf_set_option(notepad_buf, "filetype", "markdown")
			vim.api.nvim_buf_set_lines(
				notepad_buf,
				0,
				1,
				false,
				{ "# Scribble", "", "> Notepad clears when the current Neovim session closes" }
			)
		end
		-- Create a window
		notepad_win = vim.api.nvim_open_win(notepad_buf, true, {
			border = "rounded",
			relative = "editor",
			style = "minimal",
			height = math.ceil(vim.o.lines * 0.5),
			width = math.ceil(vim.o.columns * 0.5),
			row = 1, --> Top of the window
			col = math.ceil(vim.o.columns * 0.5), --> Far right; should add up to 1 with win_width
		})
		vim.api.nvim_win_set_option(notepad_win, "winblend", 30) --> Semi transparent buffer

		-- Keymaps
		local keymaps_opts = { silent = true, buffer = notepad_buf }
		vim.keymap.set("n", "<ESC>", function()
			launch_notepad()
		end, keymaps_opts)
		vim.keymap.set("n", "q", function()
			launch_notepad()
		end, keymaps_opts)
	else
		vim.api.nvim_win_hide(notepad_win)
	end
	notepad_loaded = not notepad_loaded
end
launch_notepad()
