require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!


if vim.loader then
  vim.loader.enable()
end


vim.o.swapfile = false
vim.o.backup = false
vim.o.writebackup = false

if vim.g.neovide then
  vim.o.guifont = "CaskaydiaCove Nerd Font Mono:h9"
end
