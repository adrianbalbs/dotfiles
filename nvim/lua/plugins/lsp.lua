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
            { "hrsh7th/cmp-nvim-lsp" },
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },
            { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
            { "j-hui/fidget.nvim",                        opts = {} },
        },
        config = function()
            local lsp_defaults = require("lspconfig").util.default_config

            -- Add cmp_nvim_lsp capabilities settings to lspconfig
            -- This should be executed before you configure any language server
            lsp_defaults.capabilities =
                vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

            -- LspAttach is where you enable features that only work
            -- if there is a language server active in the file
            vim.api.nvim_create_autocmd("LspAttach", {
                desc = "LSP actions",
                callback = function(event)
                    local opts = { buffer = event.buf }
                    local fzf = require('fzf-lua')

                    vim.keymap.set(
                        "n",
                        "K",
                        vim.lsp.buf.hover,
                        vim.tbl_extend("force", opts, { desc = "Show hover information" })
                    )
                    vim.keymap.set(
                        "n",
                        "gd",
                        vim.lsp.buf.definition,
                        vim.tbl_extend("force", opts, { desc = "Go to definition" })
                    )
                    vim.keymap.set(
                        "n",
                        "gD",
                        vim.lsp.buf.declaration,
                        vim.tbl_extend("force", opts, { desc = "Go to declaration" })
                    )
                    vim.keymap.set(
                        "n",
                        "gi",
                        vim.lsp.buf.implementation,
                        vim.tbl_extend("force", opts, { desc = "Go to implementation" })
                    )
                    vim.keymap.set(
                        "n",
                        "go",
                        vim.lsp.buf.type_definition,
                        vim.tbl_extend("force", opts, { desc = "Go to type definition" })
                    )
                    vim.keymap.set(
                        "n",
                        "gr",
                        fzf.lsp_references,
                        vim.tbl_extend("force", opts, { desc = "Find references" })
                    )
                    vim.keymap.set(
                        "n",
                        "gs",
                        vim.lsp.buf.signature_help,
                        vim.tbl_extend("force", opts, { desc = "Show signature help" })
                    )
                    vim.keymap.set(
                        "n",
                        "<leader>cr",
                        vim.lsp.buf.rename,
                        vim.tbl_extend("force", opts, { desc = "Rename symbol" })
                    )
                    vim.keymap.set({ "n", "x" }, "<F3>", function()
                        vim.lsp.buf.format({ async = true })
                    end, vim.tbl_extend("force", opts, { desc = "Format code" }))
                    vim.keymap.set(
                        "n",
                        "<leader>ca",
                        function()
                            fzf.lsp_code_actions({ previewer = false })
                        end,
                        vim.tbl_extend("force", opts, { desc = "Show code actions" })
                    )
                end,
            })

            local servers = {
                lua_ls = {
                    settings = {
                        Lua = {
                            runtime = {
                                version = "LuaJIT",
                            },
                            diagnostics = {
                                globals = { "vim" },
                            },
                            workspace = {
                                library = {
                                    vim.env.VIMRUNTIME,
                                },
                            },
                        },
                    }
                },
                vtsls = {},
                rust_analyzer = { enabled = false },
                gopls = {},

            }

            local ensure_installed = vim.tbl_keys(servers or {})

            vim.list_extend(ensure_installed, {
                "stylua",
                "prettier",
                "goimports",
                "gofumpt"
            })
            require('mason-tool-installer').setup { ensure_installed = ensure_installed }

            require("mason-lspconfig").setup({
                handlers = {
                    function(server_name)
                        local server = servers[server_name] or {}
                        server.capabilities = vim.tbl_deep_extend('force', {}, lsp_defaults.capabilities,
                            server.capabilities or {})
                        require("lspconfig")[server_name].setup(server)
                    end,
                },
            })
        end,
    },
}
