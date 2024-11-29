return {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
    config = function()
        -- Idk why the opts field isn't working
        require("oil").setup {
            view_options = {
                show_hidden = true,
            },
        }
        vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
        vim.keymap.set("n", "<space>-", require("oil").toggle_float, { desc = "Open parent directory float" })
    end,
}
