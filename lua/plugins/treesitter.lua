U.load(
    { "nvim-treesitter.configs", "nvim-treesitter.parsers", "treesitter-context" },
    function(configs, parsers, context)
        -- nvim-treehopper
        -- vim.keymap.set("o", "m", tsht.nodes, {noremap = true, silent = true, desc = "Treehopper"})
        -- vim.keymap.set("x", "m", tsht.nodes, {noremap = true, silent = true, desc = "Treehopper"})
        vim.cmd([[
            omap     <silent> m :<C-U>lua require('tsht').nodes()<CR>
            xnoremap <silent> m :lua require('tsht').nodes()<CR>
        ]])

        local parser_configs = parsers.get_parser_configs()
        parser_configs.haskell = {
            install_info = {
                url = "https://github.com/tree-sitter/tree-sitter-haskell",
                files = { "src/parser.c", "src/scanner.c" },
            },
        }

        configs.setup({
            ensure_installed = {
                "bash",
                -- "bibtex",
                -- "cmake",
                "comment",
                "diff",
                "fish",
                "gitignore",
                "haskell",
                "help",
                "json",
                -- "latex",
                "lua",
                "markdown",
                "python",
                "toml",
                "vim",
                "yaml",
            },
            playground = {
                enable = true,
            },
            auto_install = true,
            highlight = {
                enable = true, -- false will disable the whole extension
                disable = { "css", "latex" }, -- list of language that will be disabled
            },
            autopairs = {
                enable = true,
            },
            indent = { enable = true, disable = { "css", "python", "yaml" } },
            incremental_selection = {
                enable = true,
                keymaps = {
                    -- init_selection = "gnn",
                    -- node_incremental = ",",
                    -- scope_incremental = "grc",
                    -- node_decremental = "–",
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
                        ["]]"] = "@class.outer",
                        ["]m"] = "@function.outer",
                        ["]f"] = "@call.outer",
                        ["]c"] = "@comment.outer",
                        -- ["<Tab>"] = "@custom-capture",
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
                        ["[["] = "@class.outer",
                        ["[m"] = "@function.outer",
                        ["[f"] = "@call.outer",
                        ["[c"] = "@comment.outer",
                        -- ["<S-Tab>"] = "@custom-capture",
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
    end
)
