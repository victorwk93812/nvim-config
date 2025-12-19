--[[
    keymaps.lua: 
    All keymappings definition could be found here. 
--]]

-- Keymap Definitions

local function load_useful_keymaps()
    --[[ 
        Useful keymaps thanks to ThePrimeagen, some reddit posts and more. 
    --]]
    -- Normal mode keymaps
    vim.keymap.set("n", "<leader>o", function()
        return "m`" .. vim.v.count .. "o<Esc>``"
    end, { desc = "Insert <count> (default 1) lines below current line", expr = true })

    -- Insert 'n' lines above current line staying in normal mode (e.g. use 5<leader>O)
    vim.keymap.set("n", "<leader>O", function()
        return "m`" .. vim.v.count .. "O<Esc>``"
    end, { desc = "Insert <count> (default 1) lines above current line", expr = true })

    -- Visual mode keymaps
    vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Select lines in v-mode, move selected lines down and auto-indent" })
    vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Select lines in v-mode, move selcted lines up and auto-indent" })

    -- Cursor keymaps
    vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Down half page with cursor kept in middle" })
    vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Up half page with cursor kept in middle" })

    -- Clipboard keymaps
    vim.keymap.set("n", "<leader>y", "\"+y", { desc = "Copy to system clipboard in n-mode" })
    vim.keymap.set("v", "<leader>y", "\"+y", { desc = "Copy to system clipboard in v-mode" })
    vim.keymap.set("n", "<leader>Y", "\"+Y", { desc = "Unsure" })

    local diagnostics_active = true
    local toggle_diagnostics = function()
        diagnostics_active = not diagnostics_active
        if diagnostics_active then
            vim.diagnostic.show()
        else
            vim.diagnostic.hide()
        end
    end

    -- Toggle diagnostics keymaps
    vim.keymap.set('n', '<leader>d', toggle_diagnostics, { desc = "Toggle Diagnostics" })
    vim.keymap.set('n', '<leader>df', ':lua vim.diagnostic.open_float()<CR>', { desc = "Open floating diagnostics window" })

    -- Lazy UI keymap
    vim.keymap.set("n", "<leader>L", ":Lazy<CR>", { desc = "Open Lazy.nvim UI" })

    -- Single file quick compile/run keybindings
    vim.api.nvim_set_keymap('n', '<F8>', [[:lua QuickRun()<CR>]], { noremap = true, silent = true, desc = "Quick compile/interpret" })

    function QuickRun()
        if vim.bo.filetype == "python" then
            vim.cmd("w") -- Save the file
            vim.cmd("!python3 % > %:r-output.txt") -- Run the Python script and redirect output
        elseif vim.bo.filetype == "c" then
            vim.cmd("w") -- Save the file
            vim.cmd("!gcc -o %:r.out %") -- Compile C program and output
        elseif vim.bo.filetype == "cpp" then
            vim.cmd("w") -- Save the file
            vim.cmd("!g++ -o %:r.out %") -- Compile C++ program and output
        else
            print("Not a C/C++/Python file!")
        end
    end
end

load_useful_keymaps()

-- Lazy specs keymaps
local M = {}

function M.peek_keymaps()
    -- peek.nvim keymaps
    vim.keymap.set("n", "<leader>po", ":PeekOpen<CR>", { desc = "Open markdown preview" })
    vim.keymap.set("n", "<leader>pc", ":PeekClose<CR>", { desc = "Close markdown preview" })
end

function M.nvimtree_keymaps()
    -- nvim-tree keymaps
    vim.keymap.set("n", "<leader>nt", ":NvimTreeToggle<CR>", {desc = "Toggle nvim-tree" })
end

function M.todo_comments_keymaps()
    -- todo-comments.nvim keymaps
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
end

function M.codecompanion_keymaps()
    -- CodeCompanion keymaps
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
end

function M.copilot_keymaps()
    local suggestion = require("copilot.suggestion")
    local panel = require("copilot.panel")

    -- Suggestion Mappings (Insert Mode)
    vim.keymap.set('i', '<M-\'>', function() 
      if suggestion.is_visible() then suggestion.accept() else suggestion.next() end 
    end, { desc = "[Copilot] Accept suggestion" })

    vim.keymap.set('i', '<M-]>', function() 
      if suggestion.is_visible() then suggestion.next() end 
    end, { desc = "[Copilot] Next suggestion" })

    vim.keymap.set('i', '<M-[>', function() 
      if suggestion.is_visible() then suggestion.prev() end 
    end, { desc = "[Copilot] Previous suggestion" })

    vim.keymap.set('i', '<C-]>', function() 
      if suggestion.is_visible() then suggestion.dismiss() end 
    end, { desc = "[Copilot] Dismiss suggestion" })


    -- Panel Mappings (Normal Mode)
    vim.keymap.set('n', '<Leader>cp', function() 
      panel.open() 
    end, { desc = "[Copilot] Open Panel" })
    vim.keymap.set('n', '<Leader>cc', "<cmd>Copilot toggle<CR>", { desc = "[Copilot] Toggle Copilot" })
end

function M.auto_session_keymaps()
    vim.keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" }) -- restore last workspace session for current directory
    vim.keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save session for auto session root dir" }) -- save workspace session for current working directory
end

function M.lazygit_keymaps()
    vim.keymap.set("n", "<leader>lg", "<cmd>LazyGit<CR>", { desc = "LazyGit" })
end

function M.bind_telescope_keys()
    -- Telescope keymaps
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
    vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = 'Telescope old files' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
end

function M.bind_luasnip_keys()
    -- LuaSnip keymaps
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

function M.bind_lsp_attach_keys()
    -- LSP keymaps on LSP attach
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

function M.bind_gitsigns_keys(bufnr)
    -- gitsigns.nvim keymaps
    local gitsigns = require('gitsigns')
    local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
    end
    -- Navigation
    map('n', ']c', function()
        if vim.wo.diff then
            vim.cmd.normal({']c', bang = true})
        else
            gitsigns.nav_hunk('next')
        end
    end, { desc = "Previous hunk" })
    map('n', '[c', function()
        if vim.wo.diff then
            vim.cmd.normal({'[c', bang = true})
        else
            gitsigns.nav_hunk('prev')
        end
    end, { desc = "Next hunk" })
    -- Actions
    map('n', '<leader>hs', gitsigns.stage_hunk, { desc = "Stage hunk n-mode" })
    map('n', '<leader>hr', gitsigns.reset_hunk, { desc = "Reset hunk n-mode" })
    map('v', '<leader>hs', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = "Stage hunk v-mode" })
    map('v', '<leader>hr', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = "Reset hunk v-mode" })
    map('n', '<leader>hS', gitsigns.stage_buffer, { desc = "Stage buffer" })
    map('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = "Undo stage hunk" })
    map('n', '<leader>hR', gitsigns.reset_buffer, { desc = "Reset buffer" })
    map('n', '<leader>hp', gitsigns.preview_hunk, { desc = "Preview hunk" })
    map('n', '<leader>hb', function() gitsigns.blame_line{full=true} end, { desc = "Blame line" })
    map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = "Toggle current line blame" })
    map('n', '<leader>hd', gitsigns.diffthis, { desc = "Diff this hunk" })
    map('n', '<leader>hD', function() gitsigns.diffthis('~') end, { desc = "Diff this hunk" })
    map('n', '<leader>td', gitsigns.toggle_deleted, { desc = "Toggle deleted" })
    -- Text object
    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
end

function M.nvim_cmp_keymaps(cmp, cmp_select)
    -- nvim-cmp keymaps
    return {
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ["<C-g>"] = cmp.mapping.complete(),
    }
end

-- trouble.nvim keymaps
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

-- which-key.nvim keymaps
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
