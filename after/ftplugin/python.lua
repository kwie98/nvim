vim.cmd("abbreviate <buffer> sefl self")
vim.cmd("abbreviate <buffer> pritn print")
vim.cmd('abbreviate <buffer> __main__ if __name__ == "__main__"')
require("nvim-surround").buffer_setup({
    surrounds = {
        ["p"] = {
            add = { 'print(f"{', '=}")' },
        },
    },
})
-- TODO https://github.com/stevearc/overseer.nvim/blob/master/doc/tutorials.md#run-a-file-on-save
-- vim.keymap.set(
--     "n",
--     "<Leader>x",
--     function()
--         vim.cmd.write()
--         require("kwie.util").run("uv run python %")
--         -- return  "<CMD>OverseerShell uv run python %<CR>"
--     end,
--     -- { expr = true, desc = "Run this file" }
--     { desc = "Run this file" }
-- )
-- vim.keymap.set("n", "<Leader>X", function()
--     local f = vim.fn.expand("%")
--     local input = vim.fn.input("uv run python " .. f .. " ")
--     return "<CMD>OverseerShell uv run python % " .. input .. "<CR>"
-- end, { expr = true, desc = "Run this file with args" })
--
-- vim.keymap.set("n", "<Leader>i", "<CMD>vertical terminal OverseerShell uv run python -i %<CR>", { desc = "Run this file interactively" })
