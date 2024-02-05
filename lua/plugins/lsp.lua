local M = {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/nvim-cmp",
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/nvim-cmp',
        "L3M0N4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets",
    },
    config = function()
        -- Config Mason
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
            },
        })

        -- Config Luasnip
        local has_words_before = function()
          unpack = unpack or table.unpack
          local line, col = unpack(vim.api.nvim_win_get_cursor(0))
          return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end

        local luasnip = require("luasnip")
        -- Config cmp
        local cmp = require('cmp')
        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(),
                ['<C-n>'] = cmp.mapping.select_next_item(),
                ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.close(),
                ['<CR>'] = cmp.mapping.confirm({
                    select = true,
                }),
                ["<Tab>"] = cmp.mapping(function(fallback)
                  if cmp.visible() then
                    cmp.select_next_item()
                  -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
                  -- that way you will only jump inside the snippet region
                  elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                  elseif has_words_before() then
                    cmp.complete()
                  else
                    fallback()
                  end
                end, { "i", "s" }),

                ["<S-Tab>"] = cmp.mapping(function(fallback)
                  if cmp.visible() then
                    cmp.select_prev_item()
                  elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                  else
                    fallback()
                  end
                end, { "i", "s" }),

            }),
            sources = cmp.config.sources({
                    {name = 'nvim_lsp'},
                    {name = 'path' },
                    {name = 'luasnip'},
                    {name = 'buffer'},
                    --{name = 'copilot'},
            })
        })

        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        -- Config Lsp
        local lspconfig = require("lspconfig")
        lspconfig.lua_ls.setup({
            capabilities = capabilities,
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" },
                    },
                },
            },
        })
        lspconfig.sqlls.setup({})

        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('UserLspConfig', {}),
            callback = function(ev)
                vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                local opts_and_desc = function(opts, desc)
                    opts["desc"] = desc
                    return opts
                end

                local opts = { buffer = ev.buf, remap = false }
                vim.keymap.set("n", "gd", function()
                    vim.lsp.buf.definition()
                end, opts_and_desc(opts, "Go to definition."))

                vim.keymap.set("n", "K", function()
                    vim.lsp.buf.hover()
                end, opts_and_desc(opts, "Hover."))

                vim.keymap.set("n", "<leader>vws", function()
                    vim.lsp.buf.workspace_symbol()
                end, opts_and_desc(opts, "Workspace symbol."))

                vim.keymap.set("n", "<leader>vd", function()
                    vim.diagnostic.open_float()
                end, opts_and_desc(opts, "Open floating diagnostics."))

                vim.keymap.set("n", "[d", function()
                    vim.diagnostic.goto_next()
                end, opts_and_desc(opts, "Next diagnostic."))

                vim.keymap.set("n", "]d", function()
                    vim.diagnostic.goto_prev()
                end, opts_and_desc(opts, "Previous diagnostic."))

                vim.keymap.set("n", "<leader>ca", function()
                    vim.lsp.buf.code_action()
                end, opts_and_desc(opts, "Code action."))

                vim.keymap.set("n", "<leader>rr", function()
                    vim.lsp.buf.references()
                end, opts_and_desc(opts, "References."))

                vim.keymap.set("n", "<leader>rn", function()
                    vim.lsp.buf.rename()
                end, opts_and_desc(opts, "Rename in buffer."))

                vim.keymap.set("n", "<leader>gh", function()
                    vim.lsp.buf.signature_help()
                end, opts_and_desc(opts, "Signature help."))
            end,
        })

    end,
}

return M
