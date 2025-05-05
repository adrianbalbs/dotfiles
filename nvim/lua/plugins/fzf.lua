return {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function()
        local fzf = require "fzf-lua"
        -- TODO: Add LSP Fzf commands
        vim.keymap.set("n", "<leader>ff", fzf.files, { desc = "Fzf Files" })
        vim.keymap.set("n", "<leader>fo", fzf.oldfiles, { desc = "Fzf Oldfiles" })
        vim.keymap.set("n", "<leader>fr", fzf.resume, { desc = "Fzf Resume" })
        vim.keymap.set("n", "<leader>fg", fzf.live_grep, { desc = "Fzf Live Grep" })
        vim.keymap.set("n", "<leader>fw", fzf.lgrep_curbuf, { desc = "Fzf Live Grep Buffer" })
        vim.keymap.set("n", "<leader>fb", fzf.buffers, { desc = "Fzf Buffers" })
        vim.keymap.set("n", "<leader>fh", fzf.helptags, { desc = "Fzf Help Tags" })
        vim.keymap.set("n", "<leader>fk", fzf.keymaps, { desc = "Fzf Keymaps" })
        vim.keymap.set("n", "<leader>fm", fzf.manpages, { desc = "Fzf Manpages" })
        vim.keymap.set("n", "<leader>gf", fzf.git_files, { desc = "Fzf Git Files" })
    end,
}
