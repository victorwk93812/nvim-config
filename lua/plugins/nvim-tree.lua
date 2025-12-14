return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    keys = require("config.keymaps").nvimtree_keymaps,
    config = function()
        require("nvim-tree").setup {
            update_cwd = true,
            view = {
                width = 25, 
            }, 
            filters = {
                git_ignored = true, -- git_ignored = false, displays git ignored files
            },
        }
    end,
}
