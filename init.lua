--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
--  Setting leader key to <space>
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
--
-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Load lua/config/options.lua
require "config.options"

-- Load lua/config/keymaps.lua
require "config.keymaps"

-- Load lua/config/lazy.lua
require "config.lazy"
--
-- Load lua/config/autocmds.lua
require "config.autocmds"
