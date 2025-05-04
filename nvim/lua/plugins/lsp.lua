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
            { "williamboman/mason.nvim" },
            -- { "williamboman/mason-lspconfig.nvim" },
            { "WhoIsSethDaniel/mason-tool-installer.nvim" },
            -- { "b0o/SchemaStore.nvim" },
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

            vim.diagnostic.config { virtual_lines = true }
            vim.lsp.enable {
                "clangd",
                "lua_ls",
                "ts_ls",
                "gopls",
                "basedpyright",
                "json-lsp",
                "bash-language-server",
                "ruff",
            }
        end,
    },
}
