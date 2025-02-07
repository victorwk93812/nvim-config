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
            require("config.keymaps").bind_lsp_attach_keys()
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
				-- "clangd", 
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
            mapping = require("config.keymaps").nvim_cmp_keymaps(cmp, cmp_select),
            sources = cmp.config.sources(
                {
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' }, -- For luasnip users.
                    { name = 'buffer' },
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
