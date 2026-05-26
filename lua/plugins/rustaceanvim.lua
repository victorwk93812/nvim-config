return {
    {
        'mrcjkb/rustaceanvim',
        version = '^9',
        lazy = false,
        ft = { 'rust' },
        init = function()
            -- Configure rustaceanvim BEFORE the plugin loads.
            -- rustaceanvim reads vim.g.rustaceanvim on its first activation.
            local ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
            local capabilities = ok and cmp_nvim_lsp.default_capabilities() or vim.lsp.protocol.make_client_capabilities()

            -- System codelldb-bin (AUR). Avoids Mason download.
            local codelldb_adapter = '/usr/lib/codelldb/adapter/codelldb'
            local liblldb           = '/usr/lib/codelldb/lldb/lib/liblldb.so'

            vim.g.rustaceanvim = {
                server = {
                    capabilities = capabilities,
                    -- Bypass ~/.cargo/bin/rust-analyzer rustup shim (which errors
                    -- when the rust-analyzer component isn't installed in the
                    -- active toolchain). Use the system AUR/pacman binary.
                    cmd = { '/usr/bin/rust-analyzer' },
                    default_settings = {
                        ['rust-analyzer'] = {
                            cargo = { allFeatures = true, loadOutDirsFromCheck = true },
                            checkOnSave = true,
                            check = { command = 'clippy' },
                            procMacro = { enable = true },
                            inlayHints = { locationLinks = false },
                        },
                    },
                },
                tools = {
                    hover_actions = { auto_focus = true },
                },
                dap = {
                    adapter = require('rustaceanvim.config').get_codelldb_adapter(codelldb_adapter, liblldb),
                },
            }
        end,
        config = function()
            vim.api.nvim_create_autocmd('FileType', {
                pattern = 'rust',
                callback = function(args)
                    require('config.keymaps').bind_rustaceanvim_keys(args.buf)
                end,
            })
        end,
    },
}
