local M = {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    event = "BufReadPre",
    dependencies = {
      -- LSP Support
        {'neovim/nvim-lspconfig'},             -- Required
        {'williamboman/mason.nvim'},           -- Optional
        {'williamboman/mason-lspconfig.nvim'}, -- Optional

      -- Autocompletion
        {'hrsh7th/nvim-cmp'},       -- Required
        {'hrsh7th/cmp-nvim-lsp'},   -- Required
        {'L3MON4D3/LuaSnip'},       -- Required
        {'zbirenbaum/copilot-cmp'}, --Optional
    },
    config = function()
        local copilot = require('copilot_cmp')
        copilot.setup()

        local lsp = require('lsp-zero')

        lsp.preset("recommended")

        lsp.ensure_installed({
            "lua_ls",
            "pyright",
            "rust_analyzer",
        })

        local cmp = require('cmp')
        local cmp_select = {behavior = cmp.SelectBehavior.Select}
        local cmp_mappings = lsp.defaults.cmp_mappings({
            ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
            ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-y>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.close(),
            ['<CR>'] = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
            }),

        })

        --cmp_mappings['<Tab>'] = nil
        --cmp_mappings['<S-Tab>'] = nil

        lsp.setup_nvim_cmp({
            sources = {
                {name = 'nvim_lsp'},
                {name = 'path' },
                {name = 'luasnip'},
                {name = 'copilot'},
            },
            mapping = cmp_mappings
        })


        lsp.on_attach(function(_, bufnr)
         -- see :help lsp-zero-keybindings
         -- to learn the available actions

            lsp.default_keymaps({buffer = bufnr, remap = false})
            vim.keymap.set(
                "n",
                "gd",
                function() vim.lsp.buf.definition() end,
                {desc = "Go to definition."})

            vim.keymap.set(
                "n",
                "K",
                function() vim.lsp.buf.hover() end,
                {desc = "Hover."})

            vim.keymap.set(
                "n",
                "<leader>vws",
                function() vim.lsp.buf.workspace_symbol() end,
                {desc = "Workspace symbol."})

            vim.keymap.set(
                "n",
                "<leader>vd",
                function() vim.diagnostic.open_float() end,
                {desc = "Open floating diagnostics."})

            vim.keymap.set(
                "n",
                "[d",
                function() vim.diagnostic.goto_next() end,
                {desc = "Next diagnostic."})

            vim.keymap.set(
                "n",
                "]d",
                function() vim.diagnostic.goto_prev() end,
                {desc = "Previous diagnostic."})

            vim.keymap.set("n",
                "<leader>vca",
                function() vim.lsp.buf.code_action() end,
                {desc = "Code action."})

            vim.keymap.set("n",
                "<leader>vrr",
                function() vim.lsp.buf.references() end,
                {desc = "References."})

            vim.keymap.set("n",
                "<leader>vrn",
                function() vim.lsp.buf.rename() end,
                {desc = "Rename in buffer."})

            vim.keymap.set("n",
                "<leader>vh",
                function() vim.lsp.buf.signature_help() end,
                {desc = "Signature help."})
        end)

        lsp.set_sign_icons({
            error = '✘',
            warn = '▲',
            hint = '⚑',
            info = '»'
        })

        require('lspconfig').lua_ls.setup({
            settings = {
                Lua = {
                    diagnostics = {
                        globals = {'vim'},
                    },
                },
            },
        })

        lsp.setup()
    end,
}

return M
