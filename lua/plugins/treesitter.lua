return {
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            "nvim-treesitter/playground",
            "nvim-treesitter/nvim-treesitter-textobjects",
            "nvim-treesitter/nvim-treesitter-context",
            -- { "nvim-treesitter/nvim-treesitter-context", commit = "cacee4828152dd3a83736169ae61bbcd29a3d213" },
            -- "mfussenegger/nvim-treehopper", -- tsht
        },
        build = ":TSUpdate",
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },

        config = function()
            local configs = require("nvim-treesitter.configs")
            local parsers = require("nvim-treesitter.parsers")
            local context = require("treesitter-context")

            -- vim.cmd([[
            --     omap     <silent> m :<C-U>lua require('tsht').nodes()<CR>
            --     xnoremap <silent> m :lua require('tsht').nodes()<CR>
            -- ]])

            local parser_configs = parsers.get_parser_configs()
            parser_configs.haskell = {
                install_info = {
                    url = "https://github.com/tree-sitter/tree-sitter-haskell",
                    files = { "src/parser.c", "src/scanner.c" },
                },
            }
            if vim.fn.has("nvim-0.9") == 1 then
                vim.treesitter.language.register("bash", "zsh")
            end

            configs.setup({
                additional_vim_regex_highlighting = false,
                ensure_installed = {
                    "bash",
                    "comment",
                    "diff",
                    "gitignore",
                    "gitcommit",
                    "haskell",
                    "help",
                    "json",
                    "lua",
                    "markdown",
                    "python",
                    "toml",
                    "vim",
                    "yaml",
                },
                ignore_install = {
                    "ini",
                },
                playground = {
                    enable = true,
                },
                auto_install = true,
                highlight = {
                    enable = true, -- false will disable the whole extension
                    -- disable = { "css", "latex" }, -- list of language that will be disabled
                    disable = { "latex" }, -- list of language that will be disabled
                },
                autopairs = {
                    enable = true,
                },
                indent = {
                    enable = true,
                    disable = {
                        "css",
                        "python",
                        "yaml",
                    },
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<C-space>",
                        node_incremental = "<C-space>",
                        -- idk where I got this from but it's wrong, makes < lag in VISUAL mode:
                        -- scope_incremental = "<nop>",
                        node_decremental = "<bs>",
                    },
                },
                matchup = {
                    enable = true,
                    disable_virtual_text = true,
                },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            -- ["ab"] = "@block.outer", -- meh
                            -- ["ib"] = "@block.inner",
                            ["af"] = "@call.outer",
                            ["if"] = "@call.inner",
                            ["ac"] = "@comment.outer", -- only does one line
                            ["ic"] = "@comment.outer",
                            -- ["ai"] = "@conditional.outer", -- eh
                            -- ["ii"] = "@conditional.inner",
                            ["am"] = "@function.outer", -- actually goated
                            ["im"] = "@function.inner",
                            -- ["al"] = "@loop.outer", -- meh
                            -- ["il"] = "@loop.inner",
                            ["av"] = "@parameter.outer",
                            ["iv"] = "@parameter.inner",
                            -- ["aS"] = "@statement.outer", -- meh
                            -- ["iS"] = "@statement.outer",
                        },
                    },
                    move = {
                        enable = true,
                        goto_next_start = {
                            [",w"] = "@parameter.inner",
                            ["]v"] = "@parameter.inner",
                            ["]m"] = "@function.outer",
                            ["]f"] = "@call.outer",
                            ["]c"] = "@comment.outer",
                        },
                        goto_next_end = {
                            [",e"] = "@parameter.inner",
                            ["]V"] = "@parameter.inner",
                            ["]M"] = "@function.outer",
                            ["]F"] = "@call.outer",
                            ["]C"] = "@comment.outer",
                        },
                        goto_previous_start = {
                            [",b"] = "@parameter.inner",
                            ["[v"] = "@parameter.inner",
                            ["[m"] = "@function.outer",
                            ["[f"] = "@call.outer",
                            ["[c"] = "@comment.outer",
                        },
                        goto_previous_end = {
                            [",s"] = "@parameter.inner",
                            ["[V"] = "@parameter.inner",
                            ["[M"] = "@function.outer",
                            ["[F"] = "@call.outer",
                            ["[C"] = "@comment.outer",
                        },
                    },
                },
            })
            context.setup()
        end,
    },
    {
        "kylechui/nvim-surround",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        event = "VeryLazy",

        config = function()
            local surround = require("nvim-surround")

            surround.setup({
                keymaps = {
                    visual = "s",
                    visual_line = "gs",
                },
            })
        end,
    },
    {
        "CKolkey/ts-node-action",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        keys = {
            { "<C-Enter>", mode = "n", desc = "Node Action" },
        },

        config = function()
            local node_action = require("ts-node-action")

            node_action.setup()

            vim.keymap.set("n", "<C-Enter>", node_action.node_action, { desc = "Node Action" })
        end,
    },
}
