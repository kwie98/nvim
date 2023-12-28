vim.opt_local.conceallevel = 1
vim.opt_local.wrap = true
vim.opt_local.breakindent = true
vim.opt_local.breakindentopt = "shift:2"
vim.keymap.set("n", "<Leader>rr", "<CMD>MarkdownPreview<Enter>", { buffer = true, silent = true, desc = "Preview" })
