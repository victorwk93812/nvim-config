return {
	{ 
		"catppuccin/nvim", 
		name = "catppuccin", 
		priority = 1000, 
		config = function()
			require("catppuccin").setup({
				-- Just copying the default configuration from <https://github.com/catppuccin/nvim?tab=readme-ov-file#configuration>
				-- and <https://www.lazyvim.org/plugins/colorscheme#catppuccin>  
				flavour = "mocha", -- latte, frappe, macchiato, mocha
				background = { -- :h background
					-- light = "latte",
					light = "latte",
					dark = "mocha",
				},
				transparent_background = true, -- disables setting the background color.
				show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
				term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
				dim_inactive = {
					enabled = false, -- dims the background color of inactive window
					shade = "dark",
					percentage = 0.15, -- percentage of the shade to apply to the inactive window
				},
				no_italic = false, -- force no italic
				no_bold = false, -- force no bold
				no_underline = false, -- force no underline
				styles = { -- handles the styles of general hi groups (see `:h highlight-args`):
					comments = { "italic" }, -- change the style of comments
					conditionals = { "italic" },
					loops = {},
					functions = {},
					keywords = {},
					strings = {},
					variables = {},
					numbers = {},
					booleans = {},
					properties = {},
					types = {},
					operators = {},
					-- miscs = {}, -- uncomment to turn off hard-coded styles
				},
				color_overrides = {},
				custom_highlights = {},
				default_integrations = true,
				integrations = {
					aerial = true,
					alpha = true,
					cmp = true,
					dashboard = true,
					flash = true,
					grug_far = true,
					gitsigns = true,
					headlines = true,
					illuminate = true,
					indent_blankline = { enabled = true },
					leap = true,
					lsp_trouble = true,
					mason = true,
					markdown = true,
					native_lsp = {
						enabled = true,
						underlines = {
							errors = { "undercurl" },
							hints = { "undercurl" },
							warnings = { "undercurl" },
							information = { "undercurl" },
						},
					},
					navic = { enabled = true, custom_bg = "lualine" },
					neotest = true,
					neotree = true,
					noice = true,
					notify = true,
					semantic_tokens = true,
					snacks = true,
					telescope = true,
					treesitter = true,
					treesitter_context = true,
					which_key = true,
					nvimtree = true,
					mini = {
						enabled = true,
						indentscope_color = "",
					},
					require('lualine').setup {
						options = {
							theme = "catppuccin"
							-- ... the rest of your lualine config
						}
					}
				},
			}) 
			vim.cmd.colorscheme "catppuccin"
		end,
	},
}
