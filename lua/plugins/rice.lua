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
        -- lazy = false,
        -- init = function()
        --     vim.ui.select = function(...)
        --         require("lazy").load({ plugins = { "dressing.nvim" } })
        --         return vim.ui.select(...)
        --     end
        --     vim.ui.input = function(...)
        --         require("lazy").load({ plugins = { "dressing.nvim" } })
        --         return vim.ui.input(...)
        --     end
        -- end,

        config = function()
            local dressing = require("dressing")

            dressing.setup({
                input = {
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
                select = {
                    backend = { "telescope" },
                    -- telescope = {

                    --     border = true,
                    --     borderchars = {
                    --         prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
                    --         results = { " " },
                    --         preview = { " " },
                    --     },
                    --     -- dynamic_preview_title = true, -- trying this out
                    --     prompt_prefix = " ",
                    -- },
                },
            })
        end,
    },
    {
        "smjonas/inc-rename.nvim",
        dependencies = {
            "stevearc/dressing.nvim",
        },
        lazy = true,
        keys = {
            { "<Leader>lr", mode = "n", desc = "Rename Symbol" },
        },
        enabled = vim.fn.has("win32") == 0,

        config = function()
            require("inc_rename").setup({
                input_buffer_type = "dressing",
            })

            vim.keymap.set("n", "<leader>lr", function()
                return ":IncRename " .. vim.fn.expand("<cword>")
            end, { desc = "Rename Symbol", expr = true })
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
                signs_on_startup = {},
            })
        end,
    },
}
