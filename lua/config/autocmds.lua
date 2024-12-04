local nvimtreegroup = vim.api.nvim_create_augroup("NvimTreeAutoOpen", { clear = true })
local function initial_nvimtree()
    vim.api.nvim_create_autocmd("BufReadPost", {
        group = nvimtreegroup,
        pattern = "*",
        callback = function()
            if vim.fn.bufname("%") ~= "" and vim.bo.filetype ~= "directory" then
                vim.cmd("NvimTreeToggle")
            -- vim.cmd("winc l")
                -- local current_buf = vim.api.nvim_get_current_buf()
                -- local win_id = vim.api.nvim_buf_get_option(current_buf, 'bufwinid')
                -- vim.api.nvim_set_current_win(win_id)
            end
        end,
    })
    vim.api.nvim_create_autocmd("VimEnter", {
        group = nvimtreegroup, 
        pattern = "*", 
        command = "wincmd l", 
    })
end

-- Nvim tree on file open
initial_nvimtree()
