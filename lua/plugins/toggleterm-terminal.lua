return {
    "akinsho/toggleterm.nvim",
    event = "VeryLazy",

    config = function()
        local toggleterm = require("toggleterm")
        local terminal = require("toggleterm.terminal")
        local augroup = require("kwie.util").augroup

        vim.g.toggleterm_prev_win = vim.api.nvim_get_current_win()

        toggleterm.setup({
            size = function(term)
                if term.direction == "horizontal" then
                    return 10
                elseif term.direction == "vertical" then
                    return vim.o.columns * 0.5
                end
            end,
            open_mapping = nil,
            hide_numbers = true,
            shading_factor = "0",
            start_in_insert = false,
            insert_mappings = false,
            terminal_mappings = false,
            persist_size = true,
            direction = "horizontal",
            close_on_exit = true,
            auto_scroll = false,
            persist_mode = false,
        })

        local terms = {
            u = terminal.Terminal:new({
                cmd = vim.opt.shell:get(),
                direction = "vertical",
                count = 1,
            }),
            i = terminal.Terminal:new({
                cmd = vim.opt.shell:get(),
                direction = "vertical",
                count = 2,
            }),
            o = terminal.Terminal:new({
                cmd = "lazygit",
                direction = "tab",
                count = 3,
            }),
            p = terminal.Terminal:new({
                cmd = vim.opt.shell:get(),
                direction = "tab",
                count = 4,
            }),
        }

        --- @param this_term Terminal
        local function open_just(this_term)
            -- Close this terminal if open:
            if this_term:is_open() then
                this_term:close()
                return
            end
            -- Close the other terminals, then open this:
            for _, other_term in pairs(terms) do
                if other_term:is_open() then other_term:close() end
            end
            this_term:open()
        end

        for key, term in pairs(terms) do
            vim.keymap.set(
                { "n", "t" },
                "<C-Space>" .. key,
                function() open_just(term) end,
                { desc = "Toggle Terminal" }
            )
            vim.keymap.set(
                { "n", "t" },
                "<C-Space><C-" .. key .. ">",
                function() open_just(term) end,
                { desc = "Toggle Terminal" }
            )
        end

        -- <Esc> only in non-lazygit terminals:
        vim.api.nvim_create_autocmd("TermOpen", {
            group = augroup("toggleterm_esc"),
            callback = function()
                local name = vim.api.nvim_buf_get_name(0)
                if not string.find(name, "lazygit") then
                    vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { buffer = true })
                else
                    vim.cmd.startinsert()
                end
            end,
        })
    end,
}
