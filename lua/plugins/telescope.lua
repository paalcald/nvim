local M = {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.2',
    dependencies = {'nvim-lua/plenary.nvim'},
    keys = {
        {"<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files"},
        {"<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Grep in files"},
        {"<leader>bb", "<cmd>Telescope buffers<cr>", desc = "Find buffers"},
        {"<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Find help tags"},
    },
}

return M
