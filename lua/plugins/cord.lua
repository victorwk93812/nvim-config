return {
    {
        'vyfor/cord.nvim',
        build = ':Cord update build',
        opts = {
            advanced = {
                server = {
                    update = 'build',
                    auto_update = false,
                },
            },
        },
    }
}
