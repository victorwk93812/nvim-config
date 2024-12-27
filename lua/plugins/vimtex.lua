return {
	{
		"lervag/vimtex",
		lazy = false, -- we don't want to lazy load VimTeX
		-- tag = "v2.15", -- uncomment to pin to a specific release
		init = function()
		-- VimTeX configuration goes here, e.g.
        -- Using zathura 
		-- vim.g.vimtex_view_method = "zathura" -- zathura

        -- Using Okular
        vim.g.vimtex_view_general_viewer = 'okular'
        vim.g.vimtex_view_general_options = "--unique file:@pdf\\#src:@line@tex"

		vim.g.vimtex_quickfix_open_on_warning = 0
		-- Add option --shell-escape to vimtex
		vim.g.vimtex_compiler_latexmk = {
			options = {
				'-verbose',
				'-file-line-error',
				'-synctex=1',
				'-interaction=nonstopmode',
				'-shell-escape',
			},
		}
		end
	}
}
