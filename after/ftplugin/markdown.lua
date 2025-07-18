vim.opt_local.nu = false
vim.opt_local.rnu = false
vim.opt_local.modeline = false
vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4

vim.keymap.set("n", "<CR>", vim.lsp.buf.definition, { buffer = true })

vim.keymap.set("n", "<leader>v", function()
  local assets_dir = vim.fn.expand "%:p:h" .. "/assets"
  local name = vim.fn.input "Enter filename: "
  if name == "" then
    print "Filename cannot be empty"
    return
  end
  local filename = name .. ".png"

  if vim.fn.isdirectory(assets_dir) == 1 then
    -- TODO: Imagemagick reduce image size
    if vim.fn.has "mac" == 1 then
      vim.cmd("!pngpaste ./assets/" .. filename)
    else
      vim.cmd("!wl-paste --type=image > ./assets/" .. filename)
    end
    if vim.v.shell_error ~= 0 then
      print "Failed pasting image"
      return
    end
  else
    print "Assets directory not found"
    return
  end

  vim.fn.setreg("+", "![" .. name .. "](assets/" .. filename .. ")")
end, { buffer = true, desc = "Paste image to assets" })

vim.keymap.set("n", "<leader>w", function()
  local personal_notes_dir = vim.fn.expand "$HOME/docs/notes/personal"
  local work_notes_dir = vim.fn.expand "$HOME/docs/notes/work"

  if vim.fn.getcwd() == personal_notes_dir then
    vim.cmd("cd " .. work_notes_dir)
    vim.cmd "bufdo bd"
    vim.cmd "e index.md"
  else
    vim.cmd("cd " .. personal_notes_dir)
    vim.cmd "bufdo bd"
    vim.cmd "e index.md"
  end
end, { buffer = true, desc = "Toggle workspace notes" })
