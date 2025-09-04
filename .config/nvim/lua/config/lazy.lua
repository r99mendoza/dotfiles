-- Bootstrap lazy.nvim
-- prepending lazypath, which contains all plugins, to the runtimepath
-- rename "lazy.nvim-<version>" to "lazy.nvim" to get rid of "Clean" message when opening Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is done in init.lua by calling config.core first.

-- Setup lazy.nvim
require("lazy").setup({ { import = "plugins" }, { import = "plugins.lsp" } }, {
  -- root = vim.fn.stdpath("data") .. "/lazy", -- directory where plugins will be installed
  install = {
    missing = true, -- install missing plugins on startup. This doesn't increase startup time. Set false if no internet.
    -- try to load one of these colorschemes when starting an installation during startup
    colorscheme = { "tokyonight" },
  },
  checker = {
    enabled = true, -- automatically check for plugin updates. Set false if no internet.
    notify = false, -- get a notification when new updates are found
  },
  change_detection = {
    enabled = true, -- automatically check for config file changes and reload the ui
    notify = false, -- get a notification when changes are found
  },
})
