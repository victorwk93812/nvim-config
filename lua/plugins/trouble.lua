return {
    {
        "folke/trouble.nvim",
        opts = {}, -- for default options, refer to the configuration section for custom setup.
        cmd = "Trouble",
        keys = require("config.keymaps").trouble_keymaps,
        -- config = function ()
        --     require("trouble").setup()
        --     local actions = require("telescope.actions")
        --     local open_with_trouble = require("trouble.sources.telescope").open
        --
        --     -- Use this to add more results without clearing the trouble list
        --     local add_to_trouble = require("trouble.sources.telescope").add
        --
        --     local telescope = require("telescope")
        --
        --     telescope.setup({
        --         defaults = {
        --             -- mappings = {
        --             --     i = { ["<c-t>"] = open_with_trouble },
        --             --     n = { ["<c-t>"] = open_with_trouble },
        --             -- },
        --         },
        --     })
        -- end,
    }
}
