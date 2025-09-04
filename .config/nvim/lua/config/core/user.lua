-- use vim.opt:get() or vim.o.name
-- approximating the ternary operator in lua
-- x = a and b or c
-- If the b will evaluate to false, change the a so that it evaluates exactly opposite and therefore swaps b and c.

local M = {}

M.toggle_stuff = function()
  -- toggle line numbers
  -- vim.opt.number = vim.o.number ~= true and true or false
  -- vim.opt.relativenumber = vim.o.relativenumber ~= true and true or false
  vim.opt.number = not vim.o.number
  vim.opt.relativenumber = not vim.o.relativenumber

  -- toggle signcolumn
  vim.o.signcolumn = vim.o.signcolumn == "yes" and "no" or "yes"

  -- toggle indent-blankline plugin
  vim.cmd(":IBLToggle")

  -- toggle diagnostics
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end

M.toggle_wrap = function()
  vim.o.wrap = not vim.o.wrap
end

return M
