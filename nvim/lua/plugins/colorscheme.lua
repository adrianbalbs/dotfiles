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
        opts = {
            transparent = true,
        },
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        opts = {
            dark_variant = "main",
            styles = {
                transparency = true,
            },
        },
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        opts = {
            background = {
                light = "latte",
                dark = "frappe",
            },
            transparent_background = true,
        },
        -- init = function()
        --     vim.cmd "colorscheme catppuccin"
        -- end,
    },
}
