vim.cmd("abbreviate <buffer> sefl self")
vim.cmd('abbreviate <buffer> __main__ if __name__ == "__main__"')
require("nvim-surround").buffer_setup({
    surrounds = {
        ["p"] = {
            add = { 'print(f"{', '=}")' },
        },
    },
})
vim.keymap.set("n", "<Leader>x", "<CMD>!python %<CR>")
