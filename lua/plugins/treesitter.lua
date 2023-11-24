return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        "nvim-treesitter/nvim-treesitter-context",
    },
    build = ":TSUpdate",
    lazy = true,
    event = { "BufReadPost", "BufNewFile" },

    config = function()
        local configs = require("nvim-treesitter.configs")
        local parsers = require("nvim-treesitter.parsers")
        local context = require("treesitter-context")

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

        ---@diagnostic disable-next-line: missing-fields
        configs.setup({
            additional_vim_regex_highlighting = false,
            ensure_installed = {
                -- Overwrite parsers included in vanilla nvim 0.10:
                "c",
                "lua",
                "query",
                "vim",
                "vimdoc",
            },
            auto_install = false,
            highlight = {
                enable = true, -- false will disable the whole extension
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
                    "cpp",
                    "html",
                },
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
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
                        ["af"] = "@call.outer",
                        ["if"] = "@call.inner",
                        ["ac"] = "@comment.outer", -- only does one line
                        ["ic"] = "@comment.outer",
                        ["am"] = "@function.outer", -- actually goated
                        ["im"] = "@function.inner",
                        ["av"] = "@parameter.outer",
                        ["iv"] = "@parameter.inner",
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
}
