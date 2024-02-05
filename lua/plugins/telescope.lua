local M = {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'telescope-ui-select.nvim'},
        config = function ()
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, {desc = "Find Files"})
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, {desc = "Grep in files"})
            vim.keymap.set('n', '<leader>bb', builtin.buffers, {desc = "Find buffers"})
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, {desc = "Find help tags"})
            local telescope = require("telescope")
            telescope.setup({
                extension = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {}
                    }
                }
            })
            telescope.load_extension("ui-select")
        end
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function ()
        end
    },
}

return M
