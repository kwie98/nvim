return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    build = ":TSUpdate",
    event = "VeryLazy",
    enabled = true,

    config = function()
        local configs = require("nvim-treesitter.configs")
        local parsers = require("nvim-treesitter.parsers")

        local parser_configs = parsers.get_parser_configs()
        parser_configs.haskell = {
            install_info = {
                url = "https://github.com/tree-sitter/tree-sitter-haskell",
                files = { "src/parser.c", "src/scanner.c", "src/unicode.h" },
            },
        }
        if vim.fn.has("nvim-0.9") == 1 then
            vim.treesitter.language.register("bash", "zsh")
            vim.treesitter.language.register("html", "htmldjango")
        end

        configs.setup({
            textobjects = {
                move = {
                    enable = true,
                    goto_next_start = {
                        ["]p"] = "@parameter.inner",
                        ["]m"] = "@function.outer",
                    },
                    goto_next_end = {
                        ["]P"] = "@parameter.inner",
                        ["]M"] = "@function.outer",
                    },
                    goto_previous_start = {
                        ["[p"] = "@parameter.inner",
                        ["[m"] = "@function.outer",
                    },
                    goto_previous_end = {
                        ["[P"] = "@parameter.inner",
                        ["[M"] = "@function.outer",
                    },
                },
            },
            additional_vim_regex_highlighting = false,
            ensure_installed = {
                "bash",
                "c",
                -- "comment", -- performance issues?
                "cpp",
                "css",
                "diff",
                "dockerfile",
                "gitcommit",
                "gitignore",
                "haskell",
                "hjson",
                "html",
                "http",
                "javascript",
                "json",
                "json5",
                "jsonc",
                "lua",
                "luadoc",
                "make",
                "markdown",
                "markdown_inline",
                "python",
                "query",
                "regex",
                "rust",
                "toml",
                "tsx",
                "typescript",
                "vim",
                "vimdoc",
                "yaml",
            },
            ignore_install = {
                "xml",
            },
            auto_install = true,
            highlight = {
                enable = true,
            },
            indent = {
                enable = false, -- slow in huge files
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<Leader>v",
                    node_incremental = "v",
                    node_decremental = "<BS>",
                },
            },
        })
    end,
}
