return {
    {
        "akinsho/toggleterm.nvim",
        keys = {
            { "<Leader><Enter>", mode = "n", desc = "Toggle Terminal" },
            { "<Leader><S-Enter>", mode = "n", desc = "Focus Terminal" },
        },

        config = function()
            local toggleterm = require("toggleterm")
            local terminal = require("toggleterm.terminal")

            vim.g.toggleterm_prev_win = vim.api.nvim_get_current_win()

            vim.keymap.set("n", "<Leader><S-Enter>", function()
                local count = vim.fn.max({ vim.v.count, 1 })
                local term = terminal.get(count)
                if term == nil then
                    -- Requested terminal does not exist; make it:
                    vim.g.toggleterm_prev_win = vim.api.nvim_get_current_win()
                    vim.cmd(count .. "ToggleTerm")
                elseif term:is_focused() then
                    -- Was in terminal; go to previous window:
                    vim.api.nvim_set_current_win(vim.g.toggleterm_prev_win)
                elseif term:is_open() then
                    -- Focus open terminal:
                    vim.g.toggleterm_prev_win = vim.api.nvim_get_current_win()
                    term:focus()
                else
                    -- Open closed terminal:
                    vim.g.toggleterm_prev_win = vim.api.nvim_get_current_win()
                    term:open()
                end
            end, { desc = "Focus Terminal" })

            vim.keymap.set("n", "<Leader><Enter>", function()
                local count = vim.fn.max({ vim.v.count, 1 })
                if vim.bo.filetype == "toggleterm" then
                    -- Was in terminal; go to previous window:
                    vim.cmd(count .. "ToggleTerm")
                else
                    -- Open closed terminal without switching: TODO
                    vim.g.toggleterm_prev_win = vim.api.nvim_get_current_win()
                    vim.cmd(count .. "ToggleTerm")
                    vim.api.nvim_set_current_win(vim.g.toggleterm_prev_win)
                end
            end, { desc = "Toggle Terminal" })

            toggleterm.setup({
                size = 20,
                open_mapping = nil,
                hide_numbers = true,
                -- shade_filetypes = {},
                -- shade_terminals = true,
                shading_factor = "0",
                -- highlights = {
                --     Normal = { link = "TermNormal" },
                -- },
                start_in_insert = false,
                insert_mappings = false,
                terminal_mappings = false,
                persist_size = true,
                -- persist_mode = false,
                direction = "horizontal",
                close_on_exit = true,
                shell = "zsh",
                auto_scroll = false,
                float_opts = {
                    border = "curved",
                    winblend = 0,
                    highlights = {
                        border = "Normal",
                        background = "Normal",
                    },
                },
            })

            -- local function go_to_file(norm_cmd)
            --     local cursor = vim.api.nvim_win_get_cursor(0)
            --     local bufnr = vim.api.nvim_get_current_buf()
            --     toggleterm.toggle(0)
            --     vim.api.nvim_win_set_buf(0, bufnr)
            --     vim.api.nvim_win_set_cursor(0, cursor)
            --     vim.cmd("norm! " .. norm_cmd)
            -- end

            vim.api.nvim_create_augroup("ToggleTerm", {})
            vim.api.nvim_create_autocmd("TermOpen", {
                pattern = "term://*toggleterm#*",
                callback = function()
                    local opts = { buffer = true }
                    vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
                    -- vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd w<CR>]], opts)
                    -- vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd W<CR>]], opts)
                    -- vim.keymap.set("n", "gf", function()
                    --     go_to_file("gf")
                    -- end, opts)
                    -- vim.keymap.set("n", "gF", function()
                    --     go_to_file("gF")
                    -- end, opts)
                end,
                group = "ToggleTerm",
            })
        end,
    },
}
