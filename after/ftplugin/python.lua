vim.cmd("abbreviate <buffer> sefl self")
vim.cmd('abbreviate <buffer> __main__ if __name__ == "__main__"')
require("nvim-surround").buffer_setup({
    surrounds = {
        ["p"] = {
            add = { 'print(f"{', '=}")' },
        },
    },
})
vim.keymap.set("n", "<Leader>x", "<CMD>!uv run python %<CR>", { desc = "Run this file" })
vim.keymap.set("n", "<Leader>X", function()
    local f = vim.fn.expand("%")
    local input = vim.fn.input("uv run python " .. f .. " ")
    return "<CMD>!uv run python % " .. input .. "<CR>"
end, { expr = true, desc = "Run this file with args" })

vim.keymap.set("n", "<Leader>i", "<CMD>vertical terminal uv run python -i %<CR>", { desc = "Run this file interactively" })
