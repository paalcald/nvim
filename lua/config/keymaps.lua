vim.keymap.set("n", "<leader><leader>", ":")
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, {desc = "Open Explorer"})
vim.keymap.set('i', "<C-g>", "<Esc>")
vim.keymap.set('i', "kj", "<Esc>")
vim.keymap.set('i', "jk", "<Esc>")
--Moving highlighted text around
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
--Pasting over without saving into paste ring
vim.keymap.set("x", "<leader>p", "\"_dP")
--Buffer mappings
vim.keymap.set('n', "<leader>bn", vim.cmd.bnext, {desc = "Next buffer."})
vim.keymap.set('n', "<leader>bp", vim.cmd.bprevious, {desc = "Previous buffer."})
vim.keymap.set('n', "<leader>bk", vim.cmd.bdelete, {desc = "Kill buffer."})
vim.keymap.set("n", "<leader>bs", ":w", {desc = "Save buffer"})
