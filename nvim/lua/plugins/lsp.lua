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
        opts = {
            servers = {
                rust_analyzer = {
                    enabled = false,
                },
            },
        },
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp" },
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },
            { "WhoIsSethDaniel/mason-tool-installer.nvim" },
            { "b0o/SchemaStore.nvim" },
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
                    },
                },
                jsonls = {
                    settings = {
                        json = {
                            schemas = require("schemastore").json.schemas(),
                            validate = { enable = true },
                        },
                    },
                },
                yamlls = {
                    settings = {
                        yaml = {
                            schemaStore = {
                                enable = false,
                                url = "",
                            },
                            schemas = require("schemastore").yaml.schemas(),
                        },
                    },
                },
                html = {
                    filetypes = { "html", "htmldjango" },
                },
                tailwindcss = {},
                volar = {
                    init_options = {
                        vue = {
                            hybridMode = true,
                        },
                    },
                },
                astro = {},
                eslint = {
                    settings = {
                        -- helps eslint find the eslintrc when it's placed in a subfolder instead of the cwd root
                        filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
                        workingDirectories = { mode = "auto" },
                    },
                },
                vtsls = {
                    filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
                    settings = {
                        vtsls = {
                            -- autoUseWorkspaceTsdk = true,
                            tsserver = {
                                globalPlugins = {
                                    {
                                        name = "@vue/typescript-plugin",
                                        location = require("mason-registry")
                                            .get_package("vue-language-server")
                                            :get_install_path()
                                            .. "/node_modules/@vue/language-server",
                                        languages = { "vue" },
                                        configNamespace = "typescript",
                                        enableForWorkspaceTypeScriptVersions = true,
                                    },
                                },
                            },
                        },
                    },
                },
                rust_analyzer = false,
                gopls = {},
                basedpyright = {
                    settings = {
                        basedpyright = {
                            analysis = {
                                typeCheckingMode = "standard",
                            },
                        },
                    },
                },
                ruff = {
                    capabilities = {
                        textDocument = {
                            hover = {
                                contentFormat = { "plaintext" },
                                dynamicRegistration = false,
                            },
                        },
                    },
                },
                marksman = {},
                bashls = {},
                zls = {},
                clangd = {},
                -- ocamllsp = {
                --     filetypes = {
                --         "ocaml",
                --         "ocaml.menhir",
                --         "ocaml.interface",
                --         "ocaml.ocamllex",
                --         "reason",
                --         "dune",
                --     },
                --     root_dir = function(fname)
                --         return require("lspconfig.util").root_pattern(
                --             "*.opam",
                --             "esy.json",
                --             "package.json",
                --             ".git",
                --             "dune-project",
                --             "dune-workspace",
                --             "*.ml"
                --         )(fname)
                --     end,
                -- },
            }

            local ensure_installed = vim.tbl_keys(servers or {})

            vim.list_extend(ensure_installed, {
                "stylua",
                "prettierd",
                "goimports",
                "gofumpt",
                "shellcheck",
                "shfmt",
                "djlint",
                -- "ocamlformat",
            })
            require("mason-tool-installer").setup { ensure_installed = ensure_installed, run_on_start = true }

            require("mason-lspconfig").setup {
                handlers = {
                    function(server_name)
                        if servers[server_name] == false then
                            return
                        end
                        local server = servers[server_name] or {}
                        server.capabilities =
                            vim.tbl_deep_extend("force", {}, lsp_defaults.capabilities, server.capabilities or {})
                        require("lspconfig")[server_name].setup(server)
                    end,
                },
            }
        end,
    },
}
