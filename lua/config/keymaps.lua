--[[
    keymaps.lua: 
    All keymappings definition could be found here. 
--]]

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Select lines in v-mode, move selected lines down and auto-indent" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Select lines in v-mode, move selcted lines up and auto-indent" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Down half page with cursor kept in middle" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Up half page with cursor kept in middle" })

vim.keymap.set("n", "<leader>y", "\"+y", { desc = "Copy to system clipboard in n-mode" })
vim.keymap.set("v", "<leader>y", "\"+y", { desc = "Copy to system clipboard in v-mode" })
vim.keymap.set("n", "<leader>Y", "\"+Y", { desc = "Unsure" })

vim.keymap.set("n", "<leader>l", ":Lazy<CR>", { desc = "Open Lazy.nvim UI" })
vim.keymap.set("n", "<leader>po", ":PeekOpen<CR>", { desc = "Open markdown preview" })
vim.keymap.set("n", "<leader>pc", ":PeekClose<CR>", { desc = "Close markdown preview" })

vim.keymap.set("n", "<leader>nt", ":NvimTreeToggle<CR>", {desc = "Toggle nvim-tree" })

vim.keymap.set("n", "]t", function()
    require("todo-comments").jump_next()
end, { desc = "Next todo comment" })
vim.keymap.set("n", "[t", function()
    require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })
vim.keymap.set("n", "<leader>tt", ":TodoTelescope<CR>", { desc = "Todo comments telescope" })
vim.keymap.set("n", "<leader>tq", ":TodoQuickFix<CR>", { desc = "Todo comments quickfix list" })
vim.keymap.set("n", "<leader>tx", ":Trouble todo<CR>", { desc = "Trouble filter todo comment: {TODO, FIX, FIXME}" })
vim.keymap.set("n", "<leader>tl", ":TodoLocList<CR>", { desc = "Todo comments location list" })

local diagnostics_active = true
local toggle_diagnostics = function()
    diagnostics_active = not diagnostics_active
    if diagnostics_active then
        vim.diagnostic.show()
    else
        vim.diagnostic.hide()
    end
end

vim.keymap.set('n', '<leader>d', toggle_diagnostics, { desc = "Toggle Diagnostics" })
vim.keymap.set('n', '<leader>df', ':lua vim.diagnostic.open_float()<CR>', { desc = "Open floating diagnostics window" })

vim.api.nvim_set_keymap("n", "<leader>ct", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true, desc = "CodeCompanion Telescope integrated UI n-mode" })
vim.api.nvim_set_keymap("v", "<leader>ct", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true, desc = "CodeCompanion Telescope integrated UI v-mode" })
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

local M = {}

function M.bind_telescope_keys()
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
end

function M.bind_luasnip_keys()
    local ls = require("luasnip")
    vim.keymap.set({"i"}, "<C-K>", function() ls.expand() end, {silent = true, desc = "LuaSnip expand snippet"})
    vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump( 1) end, {silent = true, desc = "LuaSnip snippet next component"})
    vim.keymap.set({"i", "s"}, "<C-J>", function() ls.jump(-1) end, {silent = true, desc = "LuaSnip snippet precious component"})
    vim.keymap.set({"i", "s"}, "<C-E>", function()
        if ls.choice_active() then
            ls.change_choice(1)
        end
    end, {silent = true})
end

function M.bind_lsp_attach_keymaps()
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

    vim.keymap.set('n', '<leader>R', '<cmd>LspRestart<CR>', { desc = "Restart LSP" })
end

function M.nvim_cmp_keymaps(cmp, cmp_select)
    return {
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ["<C-g>"] = cmp.mapping.complete(),
    }
end

M.trouble_keymaps = {
    {
      "<leader>xx",
      "<cmd>Trouble diagnostics toggle focus=true<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>xX",
      "<cmd>Trouble diagnostics toggle filter.buf=0 focus=true<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },
    {
      "<leader>cs",
      "<cmd>Trouble symbols toggle focus=false<cr>",
      desc = "Symbols (Trouble)",
    },
    {
      "<leader>cl",
      "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      desc = "LSP Definitions / references / ... (Trouble)",
    },
    {
      "<leader>xL",
      "<cmd>Trouble loclist toggle<cr>",
      desc = "Location List (Trouble)",
    },
    {
      "<leader>xQ",
      "<cmd>Trouble qflist toggle<cr>",
      desc = "Quickfix List (Trouble)",
    },
}

M.which_key_keymaps = {
    {
        "<leader>?",
        function()
            require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
    },
}

return M
