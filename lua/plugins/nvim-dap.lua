return {
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            { 'rcarriga/nvim-dap-ui', dependencies = { 'nvim-neotest/nvim-nio' } },
            { 'theHamsta/nvim-dap-virtual-text' },
        },
        config = function()
            local dap = require('dap')
            local dapui = require('dapui')

            dapui.setup()
            require('nvim-dap-virtual-text').setup({})

            -- Auto open/close dap-ui on session start/stop.
            dap.listeners.before.attach.dapui_config = function() dapui.open() end
            dap.listeners.before.launch.dapui_config = function() dapui.open() end
            dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
            dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

            -- codelldb adapter (system pkg codelldb-bin from AUR). Shared by C/C++/Zig.
            -- Rust uses rustaceanvim's own adapter binding; see plugins/rustaceanvim.lua.
            dap.adapters.codelldb = {
                type = 'server',
                port = '${port}',
                executable = {
                    command = '/usr/lib/codelldb/adapter/codelldb',
                    args = { '--port', '${port}' },
                },
            }
            for _, ft in ipairs({ 'c', 'cpp', 'zig' }) do
                dap.configurations[ft] = {
                    {
                        name = 'Launch (codelldb)',
                        type = 'codelldb',
                        request = 'launch',
                        program = function()
                            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                        end,
                        cwd = '${workspaceFolder}',
                        stopOnEntry = false,
                    },
                }
            end

            -- Breakpoint signs.
            vim.fn.sign_define('DapBreakpoint',          { text = '●', texthl = 'DiagnosticError', linehl = '', numhl = '' })
            vim.fn.sign_define('DapBreakpointCondition', { text = '◆', texthl = 'DiagnosticWarn',  linehl = '', numhl = '' })
            vim.fn.sign_define('DapLogPoint',            { text = '◆', texthl = 'DiagnosticInfo',  linehl = '', numhl = '' })
            vim.fn.sign_define('DapStopped',             { text = '▶', texthl = 'DiagnosticOk',    linehl = 'Visual', numhl = '' })

            require('config.keymaps').bind_dap_keys()
        end,
    },
}
