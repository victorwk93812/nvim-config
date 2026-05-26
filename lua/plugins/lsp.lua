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
        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        require("fidget").setup({})

        -- Mason kept for ad-hoc tools (formatters, linters not in distro repos).
        -- LSPs + codelldb live on the system; see README.
        require("mason").setup({ max_concurrent_installers = 1 })
        require("mason-lspconfig").setup({
            ensure_installed = {},
            automatic_enable = false,
        })

        -- ------------------------------------------------------------------
        -- LSP configuration (Neovim 0.11+ API: vim.lsp.config / vim.lsp.enable).
        -- nvim-lspconfig ships preset configs under lsp/<name>.lua on the
        -- runtimepath, so we only need to add capabilities and enable.
        -- ------------------------------------------------------------------
        vim.lsp.config('*', { capabilities = capabilities })

        -- Override lua_ls so it understands the `vim` global when editing this
        -- config itself.
        vim.lsp.config('lua_ls', {
            capabilities = capabilities,
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { 'vim', 'it', 'describe', 'before_each', 'after_each' },
                    },
                    workspace = { checkThirdParty = false },
                    telemetry = { enable = false },
                },
            },
        })

        -- rust_analyzer omitted on purpose; rustaceanvim owns it.
        vim.lsp.enable({
            'lua_ls',
            'pyright',
            'jdtls',
            'texlab',
            'clangd',
            'bashls',
            'cmake',
            'gopls',
            'denols',
            'zls',
            'jsonls',
            'yamlls',
            'tinymist',
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            mapping = require("config.keymaps").nvim_cmp_keymaps(cmp, cmp_select),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                { name = 'buffer' },
                { name = 'path' },
            }),
        })

        vim.diagnostic.config({
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end,
}
