vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

vim.keymap.set("n", "<leader>l", ":Lazy<CR>", { desc = "Open Lazy.nvim UI" })
vim.keymap.set("n", "<leader>po", ":PeekOpen<CR>", { desc = "Open markdown preview" })
vim.keymap.set("n", "<leader>pc", ":PeekClose<CR>", { desc = "Close markdown preview" })

local diagnostics_active = true
local toggle_diagnostics = function()
    diagnostics_active = not diagnostics_active
    if diagnostics_active then
        vim.diagnostic.show()
    else
        vim.diagnostic.hide()
    end
end

vim.keymap.set('n', '<leader>d', toggle_diagnostics)
vim.keymap.set('n', '<leader>df', ':lua vim.diagnostic.open_float()<CR>')

vim.api.nvim_set_keymap("n", "<leader>ct", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>ct", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
--[[
    If using telescope, make use of the `ct` keymap in both visual and normal modes.
    `ct` in normal mode: Create, manage chat buffers. 
    `ct` in visual mode: Create prompt, chat with LLM, create code workflow with LLM, code quickfix, explain LSP diagnostics, code explanations, etc.
--]]

-- If not using telescope as Codecompanion chat buffer provider
-- vim.api.nvim_set_keymap("n", "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("v", "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("v", "<leader>ca", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])
