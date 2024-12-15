return {
    {
        "neanias/everforest-nvim",
        version = false,
        lazy = false,
        priority = 1000, -- make sure to load this before all the other start plugins
        -- Optional; default configuration will be used if setup isn't called.
        config = function()
            require("everforest").setup {
                -- Your config here
            }
        end,
    },
    {
        "kepano/flexoki-neovim",
        name = "flexoki",
    },
    {
        "rebelot/kanagawa.nvim",
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        init = function()
            vim.cmd "colorscheme rose-pine"
        end,
    },
}
