return {
    "nvim-lualine/lualine.nvim",
    -- enabled = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        sections = {
            lualine_x = {
                {
                    require("noice").api.statusline.mode.get,
                    cond = require("noice").api.statusline.mode.has,
                    color = { fg = "#ff9e64" },
                },

                "encoding",
                "fileformat",
                "filetype",
            },
        },
        options = {

            section_separators = "",
            component_separators = "",
            globalstatus = true,
        },
    },
}
