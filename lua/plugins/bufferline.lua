return {
    {
        "akinsho/bufferline.nvim",
        dependencies = {
            "kyazdani42/nvim-web-devicons",
        },
        event = "VeryLazy", -- from LazyVim

        config = function()
            local bufferline = require("bufferline")
            local groups = require("bufferline.groups")

            vim.keymap.set("n", "<Leader>CC", function()
                bufferline.close_in_direction("left")
                bufferline.close_in_direction("right")
            end, { desc = "Close Other Buffers" })
            vim.keymap.set("n", "<Leader>Ch", function()
                bufferline.close_in_direction("left")
            end, { desc = "Close Left" })
            vim.keymap.set("n", "<Leader>Cl", function()
                bufferline.close_in_direction("right")
            end, { desc = "Close Right" })

            bufferline.setup({
                options = {
                    custom_filter = function (bufnr, _)
                        return vim.fn.bufname(bufnr) ~= ""
                    end,
                    modified_icon = vim.g.modified_icon,
                    debug = {
                        logging = true,
                    },
                    offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
                    sort_by = "directory",
                    -- indicator = {
                    --     style = "underline",
                    -- },
                    show_buffer_close_icons = false,
                    show_close_icon = false,
                    groups = {
                        options = {
                            toggle_hidden_on_enter = true, -- when you re-enter a hidden group this options re-opens that group so the buffer is visible
                        },
                        items = {
                            groups.builtin.ungrouped,
                            {
                                name = "MA",
                                -- highlight = { gui = "underline", guisp = "blue" }, -- Optional
                                -- priority = 2, -- determines where it will appear relative to other groups (Optional)
                                -- icon = "", -- Optional
                                auto_close = false,
                                matcher = function(buf) -- Mandatory
                                    return buf.path:match("/home/konrad/Documents/uni/masterarbeit/AutoRL")
                                    -- print(vim.inspect(buf))
                                    -- return false
                                end,
                                separator = {
                                    style = groups.separator.tab,
                                },
                            },
                            {
                                name = "Vim",
                                -- highlight = { gui = "underline", guisp = "blue" }, -- Optional
                                -- priority = 2, -- determines where it will appear relative to other groups (Optional)
                                -- icon = "", -- Optional
                                auto_close = false,
                                matcher = function(buf) -- Mandatory
                                    return buf.path:match("/home/konrad/.config/nvim/")
                                    -- print(vim.inspect(buf))
                                    -- return false
                                end,
                                separator = {
                                    style = groups.separator.tab,
                                },
                            },
                            {
                                name = "Wiki",
                                -- highlight = { gui = "underline", guisp = "blue" }, -- Optional
                                -- priority = 2, -- determines where it will appear relative to other groups (Optional)
                                -- icon = "", -- Optional
                                auto_close = false,
                                matcher = function(buf) -- Mandatory
                                    return buf.filename:match("%.md")
                                end,
                                separator = {
                                    style = groups.separator.tab,
                                },
                            },
                            {
                                name = "Help",
                                -- highlight = { gui = "underline", guisp = "blue" }, -- Optional
                                -- priority = 2, -- determines where it will appear relative to other groups (Optional)
                                -- icon = "", -- Optional
                                auto_close = false,
                                matcher = function(buf) -- Mandatory
                                    return buf.buftype == "help"
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
    },
}
