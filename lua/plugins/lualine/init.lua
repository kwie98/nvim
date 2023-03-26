return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "kyazdani42/nvim-web-devicons",
        },

        config = function()
            local lualine = require("lualine")
            local components = require("plugins.lualine.components")

            lualine.setup({
                options = {
                    icons_enabled = true,
                    theme = "auto",
                    component_separators = { left = "", right = "" },
                    section_separators = { left = "", right = "" },
                    always_divide_middle = true,
                    refresh = {
                        statuslines = 1000,
                        winbar = 1000,
                    },
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = {
                        {
                            "filename",
                            path = 1,
                            symbols = {
                                modified = vim.g.modified_icon,
                                readonly = "[READONLY]",
                            },
                        },
                        {
                            "branch",
                            icon = "",
                        },
                        components.diff,
                    },
                    lualine_c = {},
                    lualine_x = { components.treesitter, components.lsp },
                    lualine_y = {
                        {
                            "filetype",
                            icons_enabled = true,
                        },
                        components.python_env,
                    },
                    lualine_z = { "progress" },
                },
                tabline = {},
                extensions = { "fugitive", "man", "nvim-dap-ui", "quickfix", "toggleterm" },
            })
            local red = "#e16d84"
            vim.cmd("hi lualine_a_terminal guibg=" .. red)
            vim.cmd("hi lualine_a_command guibg=" .. red)
            vim.cmd("hi lualine_b_terminal guifg=" .. red)
            vim.cmd("hi lualine_b_command guifg=" .. red)
        end,
    },
}
