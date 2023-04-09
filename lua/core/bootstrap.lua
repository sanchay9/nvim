local M = {}

M.lazy = function(install_path)
  ------------- base46 ---------------
  local lazy_path = vim.fn.stdpath "data" .. "/lazy/base46"

  local base46_repo = "https://github.com/sanchay9/base46"
  vim.fn.system { "git", "clone", "--depth", "1", base46_repo, lazy_path }
  vim.opt.rtp:prepend(lazy_path)

  require("base46").compile()

  --------- lazy.nvim ---------------
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", repo, install_path }
  vim.opt.rtp:prepend(install_path)

  -- install plugins
  require "plugins"
  vim.api.nvim_buf_delete(0, { force = true }) -- close lazy window

  ---------- mason packages -------------
  vim.schedule(function()
    vim.cmd "MasonInstallAll"
    local packages = table.concat(vim.g.mason_binaries_list, " ")

    require("mason-registry"):on("package:install:success", function(pkg)
      packages = string.gsub(packages, pkg.name:gsub("%-", "%%-"), "") -- rm package name

      if packages:match "%S" == nil then
        vim.schedule(function()
          vim.api.nvim_buf_delete(0, { force = true })
        end)
      end
    end)
  end)
end

return M
