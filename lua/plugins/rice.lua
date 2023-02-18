return {
    {
        "NvChad/nvim-colorizer.lua",
        event = "BufReadPost",

        config = function()
            local colorizer = require("colorizer")

            colorizer.setup({
                filetypes = { "*", "!lazy" },
                user_default_options = {
                    names = false,
                },
            })
        end,
    },
    {
        "stevearc/dressing.nvim",
        lazy = true,
        init = function()
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.select = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.select(...)
            end
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.input = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.input(...)
            end
        end,

        config = function()
            local dressing = require("dressing")

            dressing.setup({
                input = {
                    anchor = "NW",
                    border = vim.g.small_border,
                    override = function(conf)
                        conf.row = -3
                        conf.col = -2
                        return conf
                    end,
                    win_options = {
                        winblend = 0,
                    },
                },
            })
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPost", "BufNewFile" },

        config = function()
            local indent_blankline = require("indent_blankline")
            vim.g.indent_blankline_filetype_exclude = { "haskell", "help" }
            vim.g.indent_blankline_show_first_indent_level = false

            indent_blankline.setup({
                char = "▏",
                show_trailing_blankline_indent = false,
            })
        end,
    },
    {
        "smjonas/inc-rename.nvim",
        lazy = true,
        keys = {
            { "<Leader>lr", mode = "n" },
        },

        config = function()
            require("inc_rename").setup()

            vim.keymap.set("n", "<leader>lr", function()
                return ":IncRename " .. vim.fn.expand("<cword>")
            end, { desc = "Rename", expr = true })
        end,
    },
    {
        "dstein64/nvim-scrollview",
        event = "VeryLazy",

        config = function()
            local scrollview = require("scrollview")

            scrollview.setup({
                excluded_filetypes = {
                    "prompt",
                    "TelescopePrompt",
                    "fugitive",
                    "gitcommit",
                    "dapui_scopes",
                    "dapui_watches",
                    "dapui_stacks",
                    "dap-repl",
                    "dapui_console",
                    "NvimTree",
                },
            })
        end,
    },
}
