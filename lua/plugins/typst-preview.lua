return {
	{
		"chomosuke/typst-preview.nvim",
		ft = "typst",
		version = "1.*",
		build = function() require("typst-preview").update() end,
		keys = require("config.keymaps").typst_preview_keymaps,
		opts = {
			-- Reuse the tinymist binary installed via mason (see plugins/lsp.lua).
			dependencies_bin = { tinymist = "tinymist" },
			-- Linux: open preview in default browser.
			open_cmd = "xdg-open %s",
			invert_colors = "auto",
		},
	},
}
