return {
    "echasnovski/mini.nvim",
    version = false,
    config = function()
        require("mini.surround").setup {

            add = "sa", -- Add surrounding in Normal and Visual modes
            delete = "sd", -- Delete surrounding
            find = "sf", -- Find surrounding (to the right)
            find_left = "sF", -- Find surrounding (to the left)
            highlight = "sh", -- Highlight surrounding
            replace = "sr", -- Replace surrounding
            update_n_lines = "sn", -- Update `n_lines`

            suffix_last = "l", -- Suffix to search with "prev" method
            suffix_next = "n", -- Suffix to search with "next" method
        }
        local hipatterns = require "mini.hipatterns"
        hipatterns.setup {
            highlighters = {
                -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
                fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
                hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
                todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
                note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

                -- Highlight hex color strings (`#rrggbb`) using that color
                hex_color = hipatterns.gen_highlighter.hex_color(),
            },
        }
    end,
}
