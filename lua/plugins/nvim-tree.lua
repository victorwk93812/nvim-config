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
                width = 30, 
            }, 
            filters = {
                git_ignored = false, 
            },
        }
    end,
}
