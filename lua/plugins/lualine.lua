return {
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
            'catppuccin/nvim', -- ensure catppuccin theme is registered before setup
        },
        opts = {
            options = {
                theme = 'catppuccin-mocha',
            },
        },
    },
}
