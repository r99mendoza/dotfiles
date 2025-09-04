vim.keymap.set("n", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "

local function map(mode, lhs, rhs, desc)
  -- If 'desc' is nil (not provided), leave it empty
  desc = desc or ""
  local opts = { noremap = true, silent = true, desc = desc }
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- delete with "x" without copying into register
map({ 'n', 'v' }, 'x', '"_x')

map("i", "jk", "<ESC>", "Exit insert mode with jk")
map("n", "<leader>nh", ":nohl<CR>", "Clear search highlights")
map("n", "<leader>fe", ":echo (filereadable(expand(expand('<cfile>'))) ? 'File exists.' : 'File DOES NOT exist.')<CR>",
  "Checks if path name under the cursor exists")
map("n", "<leader>de",
  ":echo (isdirectory(expand(expand('<cfile>'))) ? 'Directory exists.' : 'Directory DOES NOT exist.')<CR>",
  "Checks if path name under the cursor exists and is a directory")
map("n", "<leader>cb", ":lua print('Current Buffer File Name: ' .. vim.api.nvim_buf_get_name(0))<CR>",
  "Gets full file name for current buffer")
vim.keymap.set("n", "e", ":e<space>", { noremap = true, desc = "Toggle file open" })
map("n", "<leader>s", ":write<CR>", "Save changes to file")
map("n", "<leader>w", ":set wrap<cr>", "Enable line wrap")
map("n", "<leader>nw", ":set nowrap<cr>", "Disable line wrap")
map("n", "<leader>it", ":IBLToggle<cr>", "Toggle indent lines")

-- Remapping v -> V and V -> v
map("n", "v", "V")
map("n", "V", "v")

-- Stay in indent mode in visual line mode
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Navigate buffers
map("n", "<C-j>", ":bnext<CR>", "Go to next buffer")
map("n", "<C-k>", ":bprevious<CR>", "Go to previous buffer")

-- splits
map("n", "<leader>v", ":vsplit<CR>", "Split window vertically")
map("n", "<leader>h", ":split<CR>", "Split window horizontally")

-- Better Window Navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")

local config_user = require("config.core.user")
map("n", "<leader>ts", config_user.toggle_stuff, "Toggle stuff")
map("n", "<leader>tw", config_user.toggle_wrap, "Toggle line wrap")
