return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function () 
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = { "bash", "c", "cmake", "cpp", "cuda", "lua", "python", "rust", "vim", "vimdoc", "query", "javascript", "html", },
				sync_install = false,
				highlight = { 
					enable = true, 
					disable = {
						"latex", 
					},
				},
				indent = { enable = true },  
			})
		end
	}
}
