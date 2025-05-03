return {
    {
        "mrcjkb/rustaceanvim",
        version = "^5", -- Recommended
        ft = { "rust" },
        -- opts = {
        --     on_attach = function(_, bufnr)
        --         vim.keymap.set("n", "<leader>a", function()
        --             vim.cmd.RustLsp "codeAction"
        --         end, { silent = true, buffer = bufnr })
        --         vim.keymap.set("n", "K", function()
        --             vim.cmd.RustLsp { "hover", "actions" }
        --         end, { silent = true, buffer = bufnr })
        --     end,
        --     default_settings = {
        --         ["rust-analyzer"] = {
        --             cargo = {
        --                 allFeatures = true,
        --                 loadOutDirsFromCheck = true,
        --                 buildScripts = {
        --                     enable = true,
        --                 },
        --             },
        --             -- Add clippy lints for Rust.
        --             checkOnSave = true,
        --             procMacro = {
        --                 enable = true,
        --                 ignored = {
        --                     ["async-trait"] = { "async_trait" },
        --                     ["napi-derive"] = { "napi" },
        --                     ["async-recursion"] = { "async_recursion" },
        --                 },
        --             },
        --         },
        --     },
        -- },
        config = function()
            vim.g.rustaceanvim = {
                server = {
                    on_attach = function(_, bufnr)
                        vim.keymap.set("n", "<leader>a", function()
                            vim.cmd.RustLsp "codeAction"
                        end, { silent = true, buffer = bufnr })
                        vim.keymap.set("n", "K", function()
                            vim.cmd.RustLsp { "hover", "actions" }
                        end, { silent = true, buffer = bufnr })
                    end,
                    default_settings = {
                        ["rust-analyzer"] = {
                            cargo = {
                                allFeatures = true,
                                loadOutDirsFromCheck = true,
                                buildScripts = {
                                    enable = true,
                                },
                            },
                            -- Add clippy lints for Rust.
                            checkOnSave = true,
                            procMacro = {
                                enable = true,
                                ignored = {
                                    ["async-trait"] = { "async_trait" },
                                    ["napi-derive"] = { "napi" },
                                    ["async-recursion"] = { "async_recursion" },
                                },
                            },
                        },
                    },
                },
            }
        end,
    },
    {
        "Saecki/crates.nvim",
        event = { "BufRead Cargo.toml" },
        opts = {
            completion = {
                crates = {
                    enabled = true,
                },
            },
            lsp = {
                enabled = true,
                actions = true,
                completion = true,
                hover = true,
            },
        },
    },
}
