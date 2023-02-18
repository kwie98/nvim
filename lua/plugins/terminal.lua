return {
    {
        "akinsho/toggleterm.nvim",
        keys = {
            { "<Leader><Enter>", mode = "n" },
        },

        config = function()
            local toggleterm = require("toggleterm")

            toggleterm.setup({
                size = 20,
                open_mapping = "<Leader><Enter>",
                hide_numbers = true,
                -- shade_filetypes = {},
                -- shade_terminals = true,
                shading_factor = "0",
                start_in_insert = true,
                insert_mappings = false,
                terminal_mappings = false,
                persist_size = true,
                -- persist_mode = false,
                direction = "horizontal",
                close_on_exit = true,
                shell = "fish",
                float_opts = {
                    border = "curved",
                    winblend = 0,
                    highlights = {
                        border = "Normal",
                        background = "Normal",
                    },
                },
            })

            local function go_to_file()
                local cursor = vim.api.nvim_win_get_cursor(0)
                local bufnr = vim.api.nvim_get_current_buf()
                toggleterm.toggle(0)
                vim.api.nvim_win_set_buf(0, bufnr)
                vim.api.nvim_win_set_cursor(0, cursor)
                vim.cmd("norm! gF")
            end

            vim.api.nvim_create_augroup("ToggleTerm", {})
            vim.api.nvim_create_autocmd("TermOpen", {
                pattern = "term://*toggleterm#*",
                callback = function()
                    local opts = { buffer = true }
                    vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
                    vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd w<CR>]], opts)
                    vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd W<CR>]], opts)
                    vim.keymap.set("n", "gF", go_to_file, opts)
                    vim.keymap.set("n", "gf", go_to_file, opts)
                end,
                group = "ToggleTerm",
            })
        end,
    },
}
