return {
    {
        "saghen/blink.cmp",
        dependencies = {
            "echasnovski/mini.snippets",
            "rafamadriz/friendly-snippets",
        },

        -- use a release tag to download pre-built binaries
        version = "1.*",

        config = function()
            local blink = require("blink.cmp")
            -- vim.keymap.set("i", "<Right>", function()
            --     local _, col = unpack(vim.api.nvim_win_get_cursor(0))
            --     local line = vim.api.nvim_get_current_line()
            --     if col == #line then
            --         blink.show()
            --     else
            --         vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Right>", true, false, true), "n", false)
            --     end
            -- end)
            -- vim.keymap.set({ "i", "c" }, "<C-l>", blink.show)

            blink.setup({
                snippets = { preset = "mini_snippets" },
                -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
                -- 'super-tab' for mappings similar to vscode (tab to accept)
                -- 'enter' for enter to accept
                -- 'none' for no mappings
                --
                -- All presets have the following mappings:
                -- C-space: Open menu or open docs if already open
                -- C-n/C-p or Up/Down: Select next/previous item
                -- C-e: Hide menu
                -- C-k: Toggle signature help (if signature.enabled = true)
                --
                -- See :h blink-cmp-config-keymap for defining your own keymap
                keymap = {
                    preset = "default",
                    ["<Right>"] = { "select_and_accept", "fallback" },
                    ["<C-k>"] = { "show_signature" },
                    ["<C-u>"] = { "scroll_documentation_up" },
                    ["<C-d>"] = { "scroll_documentation_down" },
                    -- ["<Esc>"] = { "hide", "fallback" }
                },

                appearance = {
                    -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                    -- Adjusts spacing to ensure icons are aligned
                    nerd_font_variant = "mono",
                },

                -- (Default) Only show the documentation popup when manually triggered
                completion = {
                    -- menu = {
                    --     auto_show = false,
                    -- },
                    keyword = {
                        range = "full",
                    },
                    list = {
                        selection = {
                            preselect = false,
                            auto_insert = false,
                        },
                    },
                    -- ghost_text = {
                    --     enabled = true,
                    -- show_with_menu = false,
                    -- },
                    documentation = {
                        auto_show = true,
                        auto_show_delay_ms = 0,
                        update_delay_ms = 50,
                    },
                    accept = {
                        auto_brackets = {
                            enabled = false, -- auto brackets dont trigger signature help?
                        },
                    },
                },

                -- Default list of enabled providers defined so that you can extend it
                -- elsewhere in your config, without redefining it, due to `opts_extend`
                sources = {
                    default = { "lsp", "path", "snippets", "buffer" },
                    min_keyword_length = 1,
                },

                -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
                -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
                -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
                --
                -- See the fuzzy documentation for more information
                fuzzy = { implementation = "prefer_rust_with_warning" },
                cmdline = {
                    completion = {
                        menu = { auto_show = true },
                        list = {
                            selection = {
                                preselect = false,
                            },
                        },
                    },
                    -- enabled = false,
                    keymap = {
                        -- preset = "enter",
                        ["<Up>"] = { "select_prev", "fallback" },
                        ["<Down>"] = { "select_next", "fallback" },
                        ["<Right>"] = { "select_and_accept", "fallback" },
                    },
                },
                signature = {
                    enabled = true,
                    window = {
                        max_height = 30,
                        show_documentation = true,
                        -- scrollbar = true,
                    },
                },
            })
        end,
        opts_extend = { "sources.default" },
    },
}
