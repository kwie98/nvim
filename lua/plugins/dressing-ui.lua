return {
    "stevearc/dressing.nvim",
    dependencies = {
        "nvim-telescope/telescope.nvim",
    },
    -- Load when needed:
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

        local function layout(opts)
            opts = opts or {}
            local theme_opts = {
                layout_strategy = "horizontal",
                layout_config = { height = 0.382, width = 0.382 },
            }
            return vim.tbl_deep_extend("force", theme_opts, opts)
        end

        dressing.setup({
            input = {
                border = vim.g.small_border,
                override = function(conf) return conf end,
                win_options = { winblend = 0 },
            },
            select = { telescope = layout() },
        })
    end,
}
