require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!


if vim.loader then
  vim.loader.enable()
end



vim.o.shell = "powershell.exe"


vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.o.swapfile = false
vim.o.backup = false
vim.o.writebackup = false
vim.opt.cmdheight = 1
vim.opt.laststatus = 2
vim.opt.hlsearch = true
vim.opt.wrap = false

if vim.g.neovide then
  vim.o.guifont = "CaskaydiaCove Nerd Font Mono:h9"
end
