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
        ---@diagnostic disable-next-line: inject-field
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
                -- "dockerfile",
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
                "dockerfile",
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
                enable = false,
                keymaps = {
                    init_selection = "<Leader>v",
                    node_incremental = "v",
                    node_decremental = "<BS>",
                },
            },
        })

        local ts_utils = require("nvim-treesitter.ts_utils")

        local node_list = {}
        local current_index = nil

        function start_select()
            node_list = {}
            current_index = nil
            current_index = 1
            vim.cmd("normal! v")
        end

        function find_expand_node(node)
            local start_row, start_col, end_row, end_col = node:range()
            local parent = node:parent()
            if parent == nil then return nil end
            local parent_start_row, parent_start_col, parent_end_row, parent_end_col = parent:range()
            if
                start_row == parent_start_row
                and start_col == parent_start_col
                and end_row == parent_end_row
                and end_col == parent_end_col
            then
                return find_expand_node(parent)
            end
            return parent
        end

        function select_parent_node()
            if current_index == nil then return end

            local node = node_list[current_index - 1]
            local parent = nil
            if node == nil then
                parent = ts_utils.get_node_at_cursor()
            else
                parent = find_expand_node(node)
            end
            if not parent then
                vim.cmd("normal! gv")
                return
            end

            table.insert(node_list, parent)
            current_index = current_index + 1
            local start_row, start_col, end_row, end_col = parent:range()
            vim.fn.setpos(".", { 0, start_row + 1, start_col + 1, 0 })
            vim.cmd("normal! v")
            vim.fn.setpos(".", { 0, end_row + 1, end_col, 0 })
        end

        function restore_last_selection()
            if not current_index or current_index <= 1 then return end

            current_index = current_index - 1
            local node = node_list[current_index]
            local start_row, start_col, end_row, end_col = node:range()
            vim.fn.setpos(".", { 0, start_row + 1, start_col + 1, 0 })
            vim.cmd("normal! v")
            vim.fn.setpos(".", { 0, end_row + 1, end_col, 0 })
        end

        vim.api.nvim_set_keymap("n", "v", ":lua start_select()<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("v", "v", ":lua select_parent_node()<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("v", "<BS>", ":lua restore_last_selection()<CR>", { noremap = true, silent = true })
    end,
}
