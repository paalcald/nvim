local M = {
    "nvimtools/none-ls.nvim",
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local null_ls = require("null-ls")
        local formatting = null_ls.builtins.formatting
        local diagnostics = null_ls.builtins.diagnostics
        local code_actions = null_ls.builtins.code_actions
        local completion = null_ls.builtins.completion
        null_ls.setup({
            sources = {
                formatting.stylua,
                formatting.black,
                diagnostics.trail_space,
                code_actions.gitsigns,
            },
        })
        vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {desc = "Format buffer"})
    end,
}

return M
