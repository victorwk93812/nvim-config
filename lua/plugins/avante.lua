-- 2025/12/29 update: 
-- Notice there are usage limits of all models.
-- Copilot Pro activated, providing a many more models to choose from.
-- Now using gemini-3-flash-preview as default model.
-- Previously used gemini free tier, which has rate limit about 20 requests per day for each model.  
--
-- Known issues:
-- 1. Models cannot edit files if the outline plugin window is open. 
--   Workaround: close the outline window (keymap <leader>to) before requesting code edits.
--
-- Gemini-cli free tier model using strategy:
-- Default: use gemini_model_1 with ACP support until rate limit of gemini_model_1
-- After rate limit: Switch to gemini, which is configured to use model gemini_model_2
local gemini_model_1 = "gemini-3-flash-preview"
local gemini_model_2 = "gemini-2.5-flash"

return {
    {
        "yetone/avante.nvim",
        -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
        -- ⚠️ must add this setting! ! !
        build = vim.fn.has("win32") ~= 0
            and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
            or "make",
        event = "VeryLazy",
        version = false, -- Never set this value to "*"! Never!
        ---@module 'avante'
        ---@type avante.Config
        opts = {
            -- add any opts here
            -- this file can contain specific instructions for your project
            instructions_file = "avante.md",
            windows = {
                position = "right", -- "right" | "left" | "top" | "bottom"
                -- wrap = true, -- similar to vim.o.wrap
                width = 30, -- for vertical layout, default = 30
                -- height = 20, -- for horizontal layout, default = 30
                -- sidebar_header = {
                --     align = "center", -- "center" | "left" | "right"
                --     rounded = true,
                -- },
                -- Optional: Set transparency (pseudo-transparency) for the input box
                -- winblend = 10, 
                input = {
                    height = 13, -- for vertical layout, default = 8
                },
            },
            -- This sets the default model provider
            -- for example the free claude sonnet chat
            -- provider = "claude",
            -- google gemini with ACP support  
            -- provider = "gemini-cli",
            -- provider = "gemini-cli-alt",
            -- could also use with no ACP
            -- provider = "gemini",
            -- Currently using, with Copilot Pro activated
            provider = "copilot",

            -- ***Note that the model selector list does not include all acp-supported models***
            -- ***If want to use ACP provider, must set that as the default provider***
            -- ***and if switched to other models, create a new chat to use ACP again.***

            -- The providers field overrides the <subentry>/<model_name> entry in the model list
            providers = {
                gemini = {
                    -- for example, this makes gemini/<default> into gemini/<gemini_model_2>
                    model = gemini_model_2,
                    timeout = 30000, -- Timeout in milliseconds
                    temperature = 0,
                    max_tokens = 4096,
                    -- optional: custom prompt instructions
                    -- system_prompt = "You are a specialized coding assistant...", 
                },
                -- claude = {
                --     endpoint = "https://api.anthropic.com",
                --     model = "claude-sonnet-4-20250514",
                --     timeout = 30000, -- Timeout in milliseconds
                --     extra_request_body = {
                --         temperature = 0.75,
                --         max_tokens = 20480,
                --     },
                -- },
                -- moonshot = {
                --     endpoint = "https://api.moonshot.ai/v1",
                --     model = "kimi-k2-0711-preview",
                --     timeout = 30000, -- Timeout in milliseconds
                --     extra_request_body = {
                --         temperature = 0.75,
                --         max_tokens = 32768,
                --     },
                -- },
            },
            acp_providers = {
                ["gemini-cli"] = {
                    command = "gemini",
                    args = { 
                        "--experimental-acp",
                        "-m", gemini_model_1,
                        -- "--approval-mode", "default",
                    },
                    env = {
                        NODE_NO_WARNINGS = "1",
                        GEMINI_API_KEY = os.getenv("GEMINI_API_KEY"),
                    },
                },
                ["gemini-cli-alt"] = {
                    command = "gemini",
                    args = { 
                        "--experimental-acp",
                        "-m", gemini_model_2,
                        -- "--approval-mode", "default",
                    },
                    env = {
                        NODE_NO_WARNINGS = "1",
                        GEMINI_API_KEY = os.getenv("GEMINI_API_KEY"),
                    },
                },
                -- not accessible yet
                -- ["claude-code"] = {
                --     command = "npx",
                --     args = { "@zed-industries/claude-code-acp" },
                --     env = {
                --         NODE_NO_WARNINGS = "1",
                --         ANTHROPIC_API_KEY = os.getenv("ANTHROPIC_API_KEY"),
                --     },
                -- },
                -- ["goose"] = {
                --     command = "goose",
                --     args = { "acp" },
                -- },
                -- ["codex"] = {
                --     command = "codex-acp",
                --     env = {
                --         NODE_NO_WARNINGS = "1",
                --         OPENAI_API_KEY = os.getenv("OPENAI_API_KEY"),
                --     },
                -- },
            },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            --- The below dependencies are optional,
            "nvim-mini/mini.pick", -- for file_selector provider mini.pick
            "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
            "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
            "ibhagwan/fzf-lua", -- for file_selector provider fzf
            "stevearc/dressing.nvim", -- for input provider dressing
            "folke/snacks.nvim", -- for input provider snacks
            "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
            "zbirenbaum/copilot.lua", -- for providers='copilot'
            {
                -- support for image pasting
                "HakonHarnes/img-clip.nvim",
                event = "VeryLazy",
                opts = {
                    -- recommended settings
                    default = {
                        embed_image_as_base64 = false,
                        prompt_for_file_name = false,
                        drag_and_drop = {
                            insert_mode = true,
                        },
                        -- required for Windows users
                        use_absolute_path = true,
                    },
                },
            },
            {
                -- Make sure to set this up properly if you have lazy=true
                'MeanderingProgrammer/render-markdown.nvim',
                opts = {
                    file_types = { "markdown", "Avante" },
                },
                ft = { "markdown", "Avante" },
            },
        },
    },
}
