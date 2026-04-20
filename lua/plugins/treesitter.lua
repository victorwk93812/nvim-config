return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			local parsers = {
				"bash", "c", "cmake", "cpp", "cuda", "lua", "python", "rust",
				"vim", "vimdoc", "query", "javascript", "html", "markdown",
				"markdown_inline", "latex", "typst", "yaml",
			}

			require("nvim-treesitter").setup({})
			require("nvim-treesitter").install(parsers)

			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					pcall(vim.treesitter.start, args.buf)
				end,
			})

			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					local ok = pcall(vim.treesitter.query.get, vim.bo[args.buf].filetype, "indents")
					if ok then
						vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})
		end,
	},
}
