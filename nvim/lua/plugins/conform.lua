return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            "<leader>cf",
            function()
                require("conform").format { async = true, lsp_format = "fallback" }
            end,
            mode = "",
            desc = "[F]ormat buffer",
        },
    },
    opts = function()
        vim.api.nvim_create_user_command("FormatDisable", function(args)
            if args.bang then
                -- FormatDisable! will disable formatting just for this buffer
                vim.b.disable_autoformat = true
            else
                vim.g.disable_autoformat = true
            end
        end, {
            desc = "Disable autoformat-on-save",
            bang = true,
        })
        vim.api.nvim_create_user_command("FormatEnable", function()
            vim.b.disable_autoformat = false
            vim.g.disable_autoformat = false
        end, {
            desc = "Re-enable autoformat-on-save",
        })

        return {
            notify_on_error = false,
            format_on_save = function(bufnr)
                -- Disable "format_on_save lsp_fallback" for languages that don't
                -- have a well standardized coding style. You can add additional
                -- languages here or re-enable it for the disabled ones.
                --
                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                    return
                end
                local disable_filetypes = { c = true, cpp = true }
                local lsp_format_opt
                if disable_filetypes[vim.bo[bufnr].filetype] then
                    lsp_format_opt = "never"
                else
                    lsp_format_opt = "fallback"
                end
                return {
                    timeout_ms = 1000,
                    lsp_format = lsp_format_opt,
                }
            end,
            formatters_by_ft = {
                lua = { "stylua" },
                javascript = { "prettierd", "prettier", stop_after_first = true },
                typescriptreact = { "prettierd", "prettier", stop_after_first = true },
                javascriptreact = { "prettierd", "prettier", stop_after_first = true },
                rust = { "rustfmt", lsp_format = "fallback" },
                python = { -- To fix auto-fixable lint errors.
                    "ruff_fix",
                    -- To run the Ruff formatter.
                    "ruff_format",
                    -- To organize the imports.
                    "ruff_organize_imports",
                },
                go = { "goimports", "gofumpt" },
                bash = { "shfmt", "shellcheck" },
                zsh = { "shfmt", "shellcheck" },
                sh = { "shfmt", "shellcheck" },
                cpp = { "clang-format" },
                -- Conform can also run multiple formatters sequentially
                --
                -- You can use 'stop_after_first' to run the first available formatter from the list
            },
            formatters = {
                black = {
                    prepend_args = { "--fast" },
                },
            },
        }
    end,
}
