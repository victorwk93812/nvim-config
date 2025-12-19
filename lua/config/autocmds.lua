local M = {}

function M.setup_workspace()
    -- Configuration: Filetypes that should trigger the Outline
    local outline_supported = { 
        "markdown", 
        "lua", 
        "python", 
        "go", 
        "rust",
        "javascript",
        "typescript",
        "yaml",
        "json",
        "toml",
        "java",
        "html",
        "css",
        "c",
        "sh",
        "zsh",
        "bash",
        "cs",
        "php",
        "cpp",
    }

    -- 1. Open NvimTree on Startup (VimEnter)
    -- Only if we opened a specific file (argc > 0) AND it's not a directory
    -- vim.api.nvim_create_autocmd("VimEnter", {
    vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
            -- Important!! Run file type check after VimEnter to ensure buffer is loaded
            -- Helper: Check if the argument is a directory
            local buftype = vim.bo.buftype
            local filetype = vim.bo.filetype
            -- "Real" files have an empty buftype. 
            -- NvimTree, Terminals, and Dashboards have 'nofile', 'terminal', etc.
            local is_real_file = (buftype == "")
            -- logic: If is entering a real file (not a special buffer) and not NvimTree
            if is_real_file and filetype ~= "NvimTree" then
                require("nvim-tree.api").tree.toggle({ focus = false, find_file = true })
                print("Hello from nvim-tree autocmd!", is_real_file)
            end
        end,
    })

    -- 2. Open Outline on FileType detection
    -- This fires whenever a buffer sets its language (start-up or later)
    vim.api.nvim_create_autocmd("FileType", {
        pattern = outline_supported,
        callback = function()
            -- We double-check that we are not in a special buffer (like a floating window or NvimTree)
            local buf_name = vim.api.nvim_buf_get_name(0)
            -- Helper: Check if the argument is a directory
            local buftype = vim.bo.buftype
            local filetype = vim.bo.filetype

            -- "Real" files have an empty buftype. 
            -- NvimTree, Terminals, and Dashboards have 'nofile', 'terminal', etc.
            local is_real_file = (buftype == "")

            if buf_name ~= "" and is_real_file then
                -- Use pcall to avoid errors if outline isn't loaded yet
                pcall(vim.cmd, "OutlineOpen")
            end
        end,
    })
end

-- !!! CALL THE FUNCTIONS HERE !!!
M.setup_workspace()

return M
