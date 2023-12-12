return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        "nvim-treesitter/nvim-treesitter-context",
    },
    build = ":TSUpdate",
    event = "VeryLazy",

    config = function()
        local configs = require("nvim-treesitter.configs")
        local parsers = require("nvim-treesitter.parsers")

        local parser_configs = parsers.get_parser_configs()
        parser_configs.haskell = {
            install_info = {
                url = "https://github.com/tree-sitter/tree-sitter-haskell",
                files = { "src/parser.c", "src/scanner.c" },
            },
        }
        if vim.fn.has("nvim-0.9") == 1 then vim.treesitter.language.register("bash", "zsh") end

        configs.setup({
            additional_vim_regex_highlighting = false,
            ensure_installed = {
                "bash",
                "c",
                "comment",
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
                "jsonc",
                "lua",
                "luadoc",
                "make",
                "markdown",
                "markdown_inline",
                "python",
                "query",
                "rust",
                "toml",
                "tsx",
                "typescript",
                "vim",
                "vimdoc",
                "yaml",
            },
            auto_install = true,
            highlight = {
                enable = true,
                disable = { "latex" },
            },
            indent = {
                enable = true,
                disable = { "css", "python", "yaml", "cpp", "html" },
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    node_decremental = "<bs>",
                },
            },
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
        })
    end,
}
