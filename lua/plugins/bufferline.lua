return {
    "akinsho/bufferline.nvim",
    dependencies = {
        "kyazdani42/nvim-web-devicons",
    },
    event = "VeryLazy", -- from LazyVim

    config = function()
        local bufferline = require("bufferline")
        local groups = require("bufferline.groups")

        vim.keymap.set("n", "<Leader>co", function()
            bufferline.close_in_direction("left")
            bufferline.close_in_direction("right")
        end, { desc = "Close Other" })
        vim.keymap.set("n", "<Leader>ch", function()
            bufferline.close_in_direction("left")
        end, { desc = "Close Left" })
        vim.keymap.set("n", "<Leader>cl", function()
            bufferline.close_in_direction("right")
        end, { desc = "Close Right" })

        bufferline.setup({
            options = {
                custom_filter = function(bufnr, _)
                    return vim.fn.bufname(bufnr) ~= ""
                end,
                modified_icon = vim.g.modified_icon,
                debug = {
                    logging = true,
                },
                offsets = {
                    {
                        filetype = "NvimTree",
                        highlight = "BufferLineNvimTreeRootFolder",
                    },
                },
                sort_by = "directory",
                show_buffer_close_icons = false,
                show_close_icon = false,
                groups = {
                    options = {
                        toggle_hidden_on_enter = true,
                    },
                    items = {
                        groups.builtin.ungrouped,
                        {
                            name = "Vim",
                            auto_close = false,
                            matcher = function(buf) -- Mandatory
                                return buf.path:match("/home/konrad/.config/nvim/")
                            end,
                            separator = {
                                style = groups.separator.tab,
                            },
                        },
                    },
                },
            },
        })
    end,
}
