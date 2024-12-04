local M = {}

local nvimtreegroup = vim.api.nvim_create_augroup("NvimTreeAutoOpen", { clear = true })
function M.initial_nvimtree()
    --[[
        Open NvimTree on file open
        An opened NvimTree conflicts with the auto-session plugin, where the latter could not save a session containing an opened NvimTree. 
        May resolve this issue in the future if I have time. 
    --]]
    vim.api.nvim_create_autocmd("BufReadPost", {
        group = nvimtreegroup,
        pattern = "*",
        callback = function()
            if vim.fn.bufname("%") ~= "" and vim.bo.filetype ~= "directory" then
                vim.cmd("NvimTreeToggle")
            end
        end,
    })
    vim.api.nvim_create_autocmd("VimEnter", {
        group = nvimtreegroup, 
        pattern = "*", 
        command = "wincmd l", 
    })
end

return M
