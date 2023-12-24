-- local keys = {}
-- local keymap_descs = {}
-- for i = 1, num_terms do
--     keys[i] = { "<C-Space>" .. i, mode = "n", desc = "Toggle Terminal" }
-- end
-- for index, value in ipairs(t) do
--
-- end
-- for _, key in ipairs({ "u", "i", "o", "p" }) do
--     -- keys[key] = { "<C-Space>" .. key, mode = {"n", "t"}, desc = "Toggle Terminal" }
--     keys[#keys + 1] = key
--     keymap_descs[#keymap_descs + 1] = { "<C-Space>" .. key, mode = { "n", "t" }, desc = "Toggle Terminal" }
--     keymap_descs[#keymap_descs + 1] = { "<C-Space><C-" .. key .. ">", mode = { "n", "t" }, desc = "Toggle Terminal" }
-- end

return {
    "akinsho/toggleterm.nvim",
    -- keys = keymap_descs,
    event = "VeryLazy",

    config = function()
        local toggleterm = require("toggleterm")
        local terminal = require("toggleterm.terminal")

        vim.g.toggleterm_prev_win = vim.api.nvim_get_current_win()

        toggleterm.setup({
            size = 16,
            open_mapping = nil,
            hide_numbers = true,
            shading_factor = "0",
            start_in_insert = true,
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
                direction = "horizontal",
                count = 1,
            }),
            i = terminal.Terminal:new({
                cmd = "lazygit",
                direction = "tab",
                count = 2,
            }),
            o = terminal.Terminal:new({
                cmd = vim.opt.shell:get(),
                direction = "tab",
                count = 3,
            }),
            p = terminal.Terminal:new({
                cmd = vim.opt.shell:get(),
                direction = "tab",
                count = 3,
            }),
        }

        --- @param this_term Terminal
        local function open_just(this_term)
            -- Close this terminal if focused:
            if this_term:is_focused() then
                this_term:close()
                return
            end
            -- Focus this terminal if open:
            if this_term:is_open() then
                this_term:focus()
                return
            end
            -- Close the other terminals, then open this:
            for _, other_term in pairs(terms) do
                if other_term:is_focused() then -- don't "close the last tab"
                    other_term:close()
                end
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

        -- <Esc> only in the first terminal:
        vim.api.nvim_create_augroup("ToggleTerm", {})
        vim.api.nvim_create_autocmd("TermOpen", {
            pattern = "term://*toggleterm#1",
            callback = function()
                local opts = { buffer = true }
                vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], opts)
            end,
            group = "ToggleTerm",
        })
    end,
}
