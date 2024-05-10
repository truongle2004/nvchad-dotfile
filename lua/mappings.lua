require "nvchad.mappings"
-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>m", ":NvimTreeToggle<CR>")



-- resize windows
map("n", "<M-right>", ":vertical resize +1<CR>")
map("n", "<M-left>", ":vertical resize -1<CR>")
map("n", "<M-Down>", ":resize +1<CR>")
map("n", "<M-Up>", ":resize -1<CR>")
-- select all
map("n", "<C-a>", "ggVG")




-- scroll up faster
map('n', '<C-k>', '<C-u>')
map('v', '<C-k>', '<C-u>')
-- scrool down faster
map('n', '<C-j>', '<C-d>')
map('v', '<C-j>', '<C-d>')

-- move next buffer
map('n', '<A-,>', ':bNext<CR>')
map('n', '<A-.>', ':bprevious<CR>')

-- code action
map('n', '<leader>ca', ':lua vim.lsp.buf.code_action()<CR>')
-- format
map('n', 'ff', ':lua vim.lsp.buf.format()<CR>')

-- go compile
map('n', '<F5>', ':GoRun<CR>')


-- trouble lsp
-- Lua
vim.keymap.set("n", "<leader>xx", function() require("trouble").toggle() end)
vim.keymap.set("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end)
vim.keymap.set("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end)
vim.keymap.set("n", "<leader>xl", function() require("trouble").toggle("loclist") end)
vim.keymap.set("n", "gR", function() require("trouble").toggle("lsp_references") end)


-- hop motion
-- place this in one of your configuration file(s)
local hop = require('hop')
local directions = require('hop.hint').HintDirection
vim.keymap.set('n', 'f', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
end, {remap=true})
vim.keymap.set('n', 'F', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
end, {remap=true})

map('n','<leader><leader>w',':HopAnywhere<CR>')



-- surround keymap
--     Old text                    Command         New text
-- --------------------------------------------------------------------------------
--     surr*ound_words             ysiw)           (surround_words)
--     *make strings               ys$"            "make strings"
--     [delete ar*ound me!]        ds]             delete around me!
--     remove <b>HTML t*ags</b>    dst             remove HTML tags
--     'change quot*es'            cs'"            "change quotes"
--     <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
--     delete(functi*on calls)     dsf             function calls
--



