return {
    {
        "hedyhli/outline.nvim",
        keys = require("config.keymaps").outline_keymaps,
        lazy = false,
        config = function()
            require("outline").setup {
                -- Your setup config here
                outline_window = {
                    width = 20,
                    relative_width = true,
                },
            }
        end,
    }
}
