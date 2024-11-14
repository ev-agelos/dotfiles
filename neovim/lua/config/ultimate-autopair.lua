return {
    {
        'altermo/ultimate-autopair.nvim',
        event = { 'InsertEnter'},
        branch = 'v0.6', --recommended as each new version will have breaking changes
        config = function()
            require 'ultimate-autopair'.init({
                require 'ultimate-autopair'.extend_default {
                    -- normal config goes here
                },
                {
                    profile = require 'ultimate-autopair.experimental.cmpair'.init,
                },
            })
        end,
    }
}
