-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- lazy
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

vim.keymap.set("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
vim.keymap.set("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })

vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })

-- windows
vim.keymap.set("n", "<leader>w", "<C-W>", { desc = "Windows", remap = true })
vim.keymap.set("n", "\\", "<C-W>s", { desc = "Split Window Below", remap = true })
vim.keymap.set("n", "|", "<C-W>v", { desc = "Split Window Right", remap = true })

-- better navigating
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- swap lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("x", "<leader>p", '"_dP')

-- For some reason this key was binded by which-key, causes a clash so removing
vim.keymap.del("n", "gc")
