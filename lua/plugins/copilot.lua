return {
	{
		'zbirenbaum/copilot.lua',
		dependencies = { 'copilotlsp-nvim/copilot-lsp' },
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require('copilot').setup({
                suggestion = {
                    enabled = true,
                    auto_trigger = true, -- I recommend setting this to true for the "ghost text" experience
                    keymap = {
                        -- Set these to false to disable the internal keymaps
                        accept = false, 
                        next = false,
                        dismiss = false,
                    },
                },
                panel = {
                    enabled = true,
                    keymap = {
                        -- Set these to false if you want to map them manually
                        open = false,
                        refresh = false,
                    },
                    layout = {
                        position = "bottom",
                        ratio = 0.25, -- Change this from 0.4 to 0.25 (make it shorter)
                    },
                },
            })
        end,
        keys = require("config.keymaps").copilot_keymaps,
	}
}

