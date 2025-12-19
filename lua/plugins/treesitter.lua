return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function () 
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = { "bash", "c", "cmake", "cpp", "cuda", "lua", "python", "rust", "vim", "vimdoc", "query", "javascript", "html", "markdown", "markdown_inline", "latex", "typst", "yaml" },
				sync_install = false,
				highlight = { 
					enable = true, 
                    -- Treesitter takes over latex syntax highlighting over 
                    -- VimTex so let it highlight, otherwise no highlighting 
                    -- is enabled
					-- disable = {
					-- 	"latex", 
					-- },
				},
				indent = { enable = true },  
			})
		end
	}
}
