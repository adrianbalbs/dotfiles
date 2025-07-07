return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        options = {
            icons_enabled = true,
            theme = "auto",
            component_separators = { left = "", right = "" },
            section_separators = { left = "", right = "" },
            disabled_filetypes = {
                statusline = {},
                winbar = {},
            },
            ignore_focus = {},
            always_divide_middle = true,
            always_show_tabline = true,
            globalstatus = false,
            refresh = {
                statusline = 1000,
                tabline = 1000,
                winbar = 1000,
                refresh_time = 16, -- ~60fps
                events = {
                    "WinEnter",
                    "BufEnter",
                    "BufWritePost",
                    "SessionLoadPost",
                    "FileChangedShellPost",
                    "VimResized",
                    "Filetype",
                    "CursorMoved",
                    "CursorMovedI",
                    "ModeChanged",
                },
            },
        },
        sections = {
            lualine_a = { "mode" },
            lualine_b = { "branch", "diff", "diagnostics" },
            lualine_c = { "filename" },
            lualine_x = { "lsp_status", "filetype" },
            lualine_y = { "location" },
            lualine_z = { "progress" },
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { "filename" },
            lualine_x = { "location" },
            lualine_y = {},
            lualine_z = {},
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {},
    },
    -- opts = function()
    --     local opts = require("lualine").get_config()
    --     opts.globalstatus = true
    --
    --     -- local trouble = require "trouble"
    --     -- local symbols = trouble.statusline {
    --     --     mode = "lsp_document_symbols",
    --     --     groups = {},
    --     --     title = false,
    --     --     filter = { range = true },
    --     --     format = "{kind_icon}{symbol.name:Normal}",
    --     --     -- The following line is needed to fix the background color
    --     --     -- Set it to the lualine section you want to use
    --     --     hl_group = "lualine_c_normal",
    --     -- }
    --     -- table.insert(opts.sections.lualine_c, {
    --     --     symbols.get,
    --     --     cond = symbols.has,
    --     -- })
    --     return opts
    -- end,
}
