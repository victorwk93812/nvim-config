return {
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = function()
            local npairs = require("nvim-autopairs")
            
            -- 2. Initialize the plugin first
            npairs.setup({})

            -- 3. Paste your custom rules below here
            local Rule = require('nvim-autopairs.rule')
            npairs.add_rule(Rule("$$","$$","tex"))
            npairs.add_rule(Rule("\\[","\\]","tex"))
            -- local cond = require('nvim-autopairs.conds'
        end,
        -- use opts = {} for passing setup options
        -- this is equivalent to setup({}) function
    }
}
