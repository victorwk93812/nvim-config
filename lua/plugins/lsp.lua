return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
    },
    config = function()
        local cmp = require('cmp')
        -- local cmp_lsp = require("cmp_nvim_lsp")
        -- Set up lspconfig.
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        local custom_attach = function()
            print("LSP started.");

            vim.keymap.set('n','<leader>gD','<cmd>lua vim.lsp.buf.declaration()<CR>', { desc = "LSP go to declaration" })
            vim.keymap.set('n','<leader>gd','<cmd>lua vim.lsp.buf.definition()<CR>', { desc = "LSP go to definition" })
            vim.keymap.set('n','<leader>K','<cmd>lua vim.lsp.buf.hover()<CR>', { desc = "LSP hover definition" })
            vim.keymap.set('n','<leader>gr','<cmd>lua vim.lsp.buf.references()<CR>', { desc = "LSP go to references" })
            vim.keymap.set('n','<leader>gs','<cmd>lua vim.lsp.buf.signature_help()<CR>', { desc = "LSP vim.lsp.buf.signature_help()" })
            vim.keymap.set('n','<leader>gi','<cmd>lua vim.lsp.buf.implementation()<CR>', { desc = "LSP vim.lsp.buf.implementation()" })
            vim.keymap.set('n','<leader>gt','<cmd>lua vim.lsp.buf.type_definition()<CR>', { desc = "LSP vim.lsp.buf.type_definition()" })
            vim.keymap.set('n','<leader>gw','<cmd>lua vim.lsp.buf.document_symbol()<CR>', { desc = "LSP vim.lsp.buf.document_symbol()" })
            vim.keymap.set('n','<leader>gW','<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', { desc = "LSP vim.lsp.buf.workspace_symbol()" })
            vim.keymap.set('n','<leader>af','<cmd>lua vim.lsp.buf.code_action()<CR>', { desc = "LSP code quickfix suggestion" })
            vim.keymap.set('n','<leader>ar','<cmd>lua vim.lsp.buf.rename()<CR>', { desc = "LSP vim.lsp.buf.rename()" })
            vim.keymap.set('n','<leader>=', '<cmd>lua vim.lsp.buf.format()<CR>', { desc = "LSP vim.lsp.buf.format()" })
            vim.keymap.set('n','<leader>ai','<cmd>lua vim.lsp.buf.incoming_calls()<CR>', { desc = "LSP vim.lsp.buf.incoming_calls()" })
            vim.keymap.set('n','<leader>ao','<cmd>lua vim.lsp.buf.outgoing_calls()<CR>', { desc = "LSP vim.lsp.buf.outgoint_calls()" })
        end
        -- local capabilities = vim.tbl_deep_extend(
        --     "force",
        --     {},
        --     vim.lsp.protocol.make_client_capabilities(),
        --     cmp_lsp.default_capabilities())

        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
				"clangd", 
            },
            handlers = {
                function(server_name) -- default handler (optional)
                    -- Setup LSP autocompletion capabilities on each installation of LSP
                    require("lspconfig")[server_name].setup {
                        on_attach = custom_attach, 
                        capabilities = capabilities
                    }
                end,
                -- ["lua_ls"] = function()
                --     local lspconfig = require("lspconfig")
                --     lspconfig.lua_ls.setup {
                --         capabilities = capabilities,
                --         settings = {
                --             Lua = {
                --                 diagnostics = {
                --                     globals = { "vim", "it", "describe", "before_each", "after_each" },
                --                 }
                --             }
                --         }
                --     }
                -- end,
            }
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ["<C-g>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources(
                {
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' }, -- For luasnip users.
                }, 
                {
                    { name = 'buffer' },
                },
                {
                    { name = 'path' },
                }
            )
        })

        vim.diagnostic.config({
            -- update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end
}
