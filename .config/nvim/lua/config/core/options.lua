local options = {
  number = true,
  relativenumber = true,
  expandtab = true,  -- In Insert mode: convert tabs to spaces
  tabstop = 4,       -- insert 4 spaces for a tab
  softtabstop = 4,
  shiftwidth = 4,    -- the number of spaces inserted for each indentation
  autoindent = true, -- copy indent from current line when starting a new
  mouse = "",        -- allow the mouse to be used in neovim
  mousefocus = true,
  mousehide = true,
  mousemodel = "extend",
  backspace = "indent,eol,start",                     -- allow backspace on indent, end of line or insert mode start position
  hlsearch = true,                                    -- highlight all matches on previous search pattern
  ignorecase = true,                                  -- ignore case in search patterns
  smartcase = true,                                   -- smart case
  incsearch = true,                                   -- makes search interactive
  smartindent = true,                                 -- make indenting smarter again
  showmode = false,                                   -- we don't need to see things like -- INSERT -- anymore
  scrolloff = 999,                                    -- Keep cursor centered vertically
  cursorline = true,                                  -- highlight the current line
  termguicolors = true,                               -- set term gui colors to enable highlight groups (most terminals support this)
  directory = "/tmp/" .. os.getenv("USER") .. "/vim", -- list of dir names for the swap file
  updatetime = 300,                                   -- faster completion (4000ms default)
  numberwidth = 2,                                    -- set number column width to 2 {default 4}
  signcolumn = "yes",                                 -- always show the sign column, otherwise it would shift the text each time
  wrap = true,                                        -- display lines as one long line
  breakindent = true,
  splitright = true,                                  -- split vertical window to the right
  splitbelow = true,                                  -- split horizontal window to the bottom
  winborder = "rounded"                               -- set the default border for all floating windows
}

-- Note: vim.opt:remove()
-- Remove a value from string-style options. See ":h set-="
-- These are equivalent:
-- vim.opt.wildignore:remove("*.pyc")
-- vim.opt.wildignore = vim.opt.wildignore - "*.pyc"

vim.opt.shortmess:append("at")
vim.opt.formatoptions:remove("t")
vim.opt.clipboard:append("unnamedplus") -- use system clipboard as default register

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- Figure out the system Python for Neovim.
if vim.fn.exists("$VIRTUAL_ENV") then
  vim.g.python3_host_prog = vim.fn.substitute(vim.fn.system("/bin/which -a python3 | head -n1"), "\n", "", "g")
  -- else
  --   vim.g.python3_host_prog = "$HOME/envs/python3.13.3/bin/python3"
end

-- Command to start the Node.js host. Setting this makes startup faster.
-- vim.g.node_host_prog = "/usr/bin/neovim-node-host" -- see :h g:node_host_prog
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

-- Jump to the last position when reopening a file
local group = vim.api.nvim_create_augroup("jump_to_last_position", { clear = true })
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
  callback = function(args)
    local line = vim.fn.line
    local valid_line = line([['"]]) >= 1 and line([['"]]) <= line("$")
    local not_commit = vim.b[args.buf].filetype ~= 'commit' -- ~= means not equal to

    if valid_line and not_commit then
      vim.cmd([[normal! g`"zz]])
    end
  end
})

-- Undercurl
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = "Cyan" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = "Red" })
