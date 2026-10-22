-- codelldb paths, shared by plugins/nvim-dap.lua and plugins/rustaceanvim.lua.
-- Prefers Mason's codelldb; falls back to the AUR codelldb-bin layout.
local M = {}

local mason_root = vim.fn.stdpath('data') .. '/mason/packages/codelldb/extension'
local system_root = '/usr/lib/codelldb'

local root = vim.fn.executable(mason_root .. '/adapter/codelldb') == 1 and mason_root or system_root

M.adapter = root .. '/adapter/codelldb'
M.liblldb = root .. '/lldb/lib/liblldb.so'

return M
