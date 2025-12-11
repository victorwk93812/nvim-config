-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
    -- modular approach: using `require 'path/name'` will
    -- include a plugin definition from file lua/path/name.lua
    -- List plugins here
    require "plugins.lualine",
    require "plugins.catppuccin",
    require "plugins.indent-blankline",
    require "plugins.nvim-tree",

    require "plugins.telescope",

    require "plugins.treesitter",

    require "plugins.vimtex",

    require "plugins.luasnip",
    require "plugins.lsp",

    require "plugins.trouble",

    -- require "plugins.peek",

    require "plugins.todo-comments",

    require "plugins.gitsigns", 

    require "plugins.lazygit", 

    require "plugins.auto-session",

    require "plugins.undotree",

    require "plugins.render-markdown",

    require "plugins.cord",

    require "plugins.image-nvim", 

    -- require "plugins.codecompanion", -- Still too buggy as of 2025-12-06

    require "plugins.copilot",

    require "plugins.which-key",
    -- automatically check for plugin updates
    -- checker = { enabled = true },
})
