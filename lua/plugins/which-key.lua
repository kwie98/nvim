return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",

        config = function()
            local which_key = require("which-key")

            which_key.setup({
                plugins = {
                    marks = true, -- shows a list of your marks on ' and `
                    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
                    spelling = {
                        enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
                        suggestions = 20, -- how many suggestions should be shown in the list?
                    },
                    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
                    -- No actual key bindings are created
                    presets = {
                        operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
                        motions = false, -- adds help for motions
                        text_objects = false, -- help for text objects triggered after entering an operator
                        windows = true, -- default bindings on <c-w>
                        nav = true, -- misc bindings to work with windows
                        z = true, -- bindings for folds, spelling and others prefixed with z
                        g = true, -- bindings for prefixed with g
                    },
                },
                -- add operators that will trigger motion and text object completion
                -- to enable all native operators, set the preset / operators plugin above
                -- operators = { gc = "Comments" },
                key_labels = {
                    -- override the label used to display some keys. It doesn't effect WK in any other way.
                    -- For example:
                    -- ["<space>"] = "SPC",
                    -- ["<CR>"] = "RET",
                    -- ["<tab>"] = "TAB",
                },
                icons = {
                    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
                    separator = ":", -- symbol used between a key and it's label
                    group = "+", -- symbol prepended to a group
                },
                popup_mappings = {
                    scroll_down = "<c-d>", -- binding to scroll down inside the popup
                    scroll_up = "<c-u>", -- binding to scroll up inside the popup
                },
                window = {
                    border = vim.g.small_border, -- none, single, double, shadow
                    position = "bottom", -- bottom, top
                    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
                    padding = { 1, 1, 1, 1 }, -- extra window padding [top, right, bottom, left]
                    winblend = 0,
                },
                layout = {
                    height = { min = 4, max = 25 }, -- min and max height of the columns
                    width = { min = 20, max = 50 }, -- min and max width of the columns
                    spacing = 3, -- spacing between columns
                    align = "left", -- align columns left, center or right
                },
                ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
                hidden = {
                    "<silent>",
                    "<CMD>",
                    "<CR>",
                    "call",
                    "lua",
                    "^:",
                    "^ ",
                    "<Plug>",
                    -- "require'nvim--treesitter.textobjects.select'.select_textobject",
                    "<Cmd> require",
                }, -- hide mapping boilerplate
                show_help = true, -- show help message on the command line when the popup is visible
                triggers = "auto", -- automatically set up triggers TODO test
                -- triggers = { "<leader>", "g" }, -- or specify a list manually TODO include register triggers
                triggers_blacklist = {
                    -- list of mode / prefixes that should never be hooked by WhichKey
                    -- this is mostly relevant for key maps that start with a native binding
                    -- most people should not need to change this
                    i = { "j", "k" },
                    v = { "j", "k" },
                },
            })

            local opts = {
                mode = "n",
                prefix = "<leader>",
                buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
                silent = true, -- use `silent` when creating keymaps
                noremap = true, -- use `noremap` when creating keymaps
                nowait = false, -- TODO what does this do?
            }

            local mappings = {
                w = {
                    name = "Wiki",
                },
                g = {
                    name = "Git",
                },
                d = {
                    name = "Debug",
                },
                l = {
                    name = "LSP",
                },
                m = {
                    name = "Module Info",
                },
                s = {
                    name = "Search",
                },
                u = "which_key_ignore",
                i = "which_key_ignore",
                o = "which_key_ignore",
                p = "which_key_ignore",
            }

            local v_opts = {
                mode = "v",
                prefix = "<Leader>",
                buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
                silent = true, -- use `silent` when creating keymaps
                noremap = true, -- use `noremap` when creating keymaps
                nowait = true, -- use `nowait` when creating keymaps
            }

            local v_mappings = {
                g = {
                    name = "Git",
                },
            }

            which_key.register(mappings, opts)
            which_key.register(v_mappings, v_opts)
        end,
    },
}
