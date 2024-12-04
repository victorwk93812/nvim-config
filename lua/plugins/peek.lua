return {
	{
		"toppair/peek.nvim",
		event = { "VeryLazy" },
		build = "deno task --quiet build:fast",
        keys = require("config.keymaps").peek_keymaps,
		config = function()
			require("peek").setup({
				-- Preview by a new chromium window
				app = { 'chromium', '--new-window' }, 
				-- Preview by a new chromium tab
				-- app = 'chromium',
			})
			vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
			vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
		end,
	},
}
