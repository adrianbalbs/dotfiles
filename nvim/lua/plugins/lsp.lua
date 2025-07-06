return {
    {
        "williamboman/mason.nvim",
        lazy = false,
        opts = {},
    },
    {
        "neovim/nvim-lspconfig",
        cmd = { "LspInfo", "LspInstall", "LspStart" },
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            -- { "hrsh7th/cmp-nvim-lsp" },
            { "williamboman/mason.nvim" },
            -- { "williamboman/mason-lspconfig.nvim" },
            { "WhoIsSethDaniel/mason-tool-installer.nvim" },
            { "b0o/SchemaStore.nvim" },
        },
        config = function()
            vim.api.nvim_create_autocmd("LspAttach", {
                desc = "Configure LSP keymappings and actions",
                callback = function(event)
                    local opts = { buffer = event.buf }
                    local fzf = require "fzf-lua"

                    local function map(mode, lhs, rhs, desc)
                        vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", opts, { desc = desc }))
                    end

                    -- Navigation and Information
                    map("n", "K", vim.lsp.buf.hover, "Show hover information")
                    map("n", "gd", vim.lsp.buf.definition, "Go to definition")
                    map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
                    map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
                    map("n", "go", vim.lsp.buf.type_definition, "Go to type definition")
                    map("n", "gs", vim.lsp.buf.signature_help, "Show signature help")

                    -- References and Actions
                    map("n", "gr", fzf.lsp_references, "Find references")
                    map("n", "<leader>cr", vim.lsp.buf.rename, "Rename symbol")
                    map("n", "<leader>ca", function()
                        fzf.lsp_code_actions { previewer = false }
                    end, "Show code actions")
                    map("n", "<leader>fs", function()
                        fzf.lsp_document_symbols { previewer = false }
                    end, "Find LSP Symbols")
                end,
            })

            vim.lsp.config("*", {
                capabilities = {
                    textDocument = {
                        semanticTokens = {
                            multilineTokenSupport = true,
                        },
                    },
                },
                root_markers = { ".git" },
            })

            -- For some reason the clangd settings in the lsp folder are not being merged, so need to change here
            vim.lsp.config.clangd = {
                cmd = {
                    "clangd",
                    "--background-index",
                    "--clang-tidy",
                    "--completion-style=detailed",
                    "--header-insertion=iwyu",
                },
                root_markers = { "compile_commands.json", "compile_flags.txt", ".clang-tidy", ".clang-format" },
                filetypes = { "c", "cpp" },
            }
            vim.diagnostic.config { virtual_lines = true }

            vim.lsp.enable {
                "cssls",
                "hyprls",
                "clangd",
                "lua_ls",
                "vtsls",
                "gopls",
                "basedpyright",
                "json-lsp",
                "bashls",
                "ruff",
                "astro",
                "marskman",
            }
        end,
    },
}
