return {
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim", -- required
            "sindrets/diffview.nvim", -- optional - Diff integration
            "ibhagwan/fzf-lua", -- optional
        },
        config = function()
            local neogit = require "neogit"
            vim.keymap.set("n", "<leader>gg", function()
                neogit.open { kind = "auto" }
            end, { desc = "Open neogit" })
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            signs = {
                add = { text = "▎" },
                change = { text = "▎" },
                delete = { text = "" },
                topdelete = { text = "" },
                changedelete = { text = "▎" },
                untracked = { text = "▎" },
            },
            signs_staged = {
                add = { text = "▎" },
                change = { text = "▎" },
                delete = { text = "" },
                topdelete = { text = "" },
                changedelete = { text = "▎" },
            },
            on_attach = function(bufnr)
                local gitsigns = require "gitsigns"

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map("n", "]c", function()
                    if vim.wo.diff then
                        vim.cmd.normal { "]c", bang = true }
                    else
                        gitsigns.nav_hunk "next"
                    end
                end)

                map("n", "[c", function()
                    if vim.wo.diff then
                        vim.cmd.normal { "[c", bang = true }
                    else
                        gitsigns.nav_hunk "prev"
                    end
                end)

                -- Actions
                map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage current hunk" })
                map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Reset current hunk" })
                map("v", "<leader>hs", function()
                    gitsigns.stage_hunk { vim.fn.line ".", vim.fn.line "v" }
                end, { desc = "Stage selected hunk" })
                map("v", "<leader>hr", function()
                    gitsigns.reset_hunk { vim.fn.line ".", vim.fn.line "v" }
                end, { desc = "Reset selected hunk" })
                map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Stage entire buffer" })
                map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Reset entire buffer" })
                map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview current hunk" })
                map("n", "<leader>hb", function()
                    gitsigns.blame_line { full = true }
                end, { desc = "Blame current line (detailed)" })
                map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Toggle line blame" })
                map("n", "<leader>hd", gitsigns.diffthis, { desc = "View diff against index" })
                map("n", "<leader>hD", function()
                    gitsigns.diffthis "~"
                end, { desc = "View diff against last commit" })
                map("n", "<leader>td", gitsigns.preview_hunk_inline, { desc = "Toggle showing deleted lines" })

                -- Text object mappings
                map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk (text object)" })
            end,
        },
    },
}
