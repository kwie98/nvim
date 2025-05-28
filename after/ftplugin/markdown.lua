vim.opt_local.wrap = true
vim.opt_local.breakindentopt = "shift:2"
vim.keymap.set("n", "<Leader>x", "<CMD>MarkdownPreview<Enter>", { buffer = true, silent = true, desc = "Preview" })
