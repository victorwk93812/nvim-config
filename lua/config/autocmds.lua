local M = {}

function M.init_nvimtree()
    vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
            if vim.fn.argc() > 0 then
                require("nvim-tree.api").tree.toggle({ focus = false, find_file = true })
            end
        end,
    })
end

-- !!! CALL THE FUNCTION HERE !!!
M.init_nvimtree()

return M
