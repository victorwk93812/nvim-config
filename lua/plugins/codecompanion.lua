return{
    {
        "olimorris/codecompanion.nvim",
        version = "v17.33.0", -- Gemini_cli is broken this version
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            -- The following are optional:
            { "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion" } },
        },
        config = function()
            require("codecompanion").setup({
                display = {
                    chat = {
                        render_headers = false,
                        window = {
                            -- layout = "vertical",
                            -- position = "right",
                            -- width = 0.25, -- 0.25 = 25% of screen width
                            layout = "horizontal",
                            position = "bottom",
                            height = 0.25, -- 0.3 = 30% of screen
                        },
                    },
                    action_palette = {
                        provider = "telescope", -- Set to "telescope" or "mini_pick"
                    },
                },
                strategies = {
                    chat = {
                        adapter = "gemini",
                        -- adapter = "copilot",
                    },
                    inline = {
                        adapter = "gemini",
                        -- adapter = "copilot",
                    },
                    agent = {
                        adapter = "gemini",
                        -- adapter = "copilot",
                    },
                },
                adapters = {
                    http = {
                        copilot = function()
                            return require("codecompanion.adapters").extend("copilot", {
                                -- Check here for default models:
                                -- https://github.com/olimorris/codecompanion.nvim/blob/main/lua/codecompanion/adapters/http/anthropic.lua
                                schema = {
                                    model = {
                                        -- Claude 3.5 Sonnet is currently the best coding model available via Copilot
                                        default = "claude-sonnet-4-20250514", 
                                    },
                                },
                            })
                        end,
                        gemini = function()
                            return require("codecompanion.adapters").extend("gemini", {
                                schema = {
                                    model = {
                                        -- Check here for default models:
                                        -- https://github.com/olimorris/codecompanion.nvim/blob/main/lua/codecompanion/adapters/http/gemini.lua
                                        default = "gemini-2.5-flash", 
                                    },
                                },
                                env = {
                                    api_key = "GEMINI_API_KEY", -- Make sure to set this environment variable"
                                },
                            })
                        end,
                    },
                    acp = {
                        gemini_cli = function()
                            -- Check here for default models:
                            -- https://github.com/olimorris/codecompanion.nvim/blob/main/lua/codecompanion/adapters/acp/gemini_cli.lua
                            return require("codecompanion.adapters").extend("gemini_cli", {
                                defaults = {
                                    auth_method = "gemini-api-key", -- "oauth-personal"|"gemini-api-key"|"vertex-ai"
                                },
                                env = {
                                    GEMINI_API_KEY = "GEMINI_API_KEY", -- Make sure to set this environment variable"
                                },
                            })
                        end,
                    },

                },
            })
            -- require("codecompanion").chat({ 
            --     window_opts = { 
            --         position = "right", 
            --         width = 0.25 
            --     }
            -- })
        end,
        lazy = false,
        -- cmd = { 
        --     "CodeCompanionActions", 
        --     "CodeCompanionChat", 
        --     "CodeCompanionActions", 
        --     "CodeCompanionCmd",
        --     "Telescope codecompanion" 
        -- }, -- Lazy-load commands
        keys = require("config.keymaps").codecompanion_keymaps,
    }
}
