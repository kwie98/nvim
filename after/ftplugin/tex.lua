vim.keymap.set("n", "<Leader>x", "<CMD>TexlabForward<CR>", { buffer = true, silent = true, desc = "Preview" })
vim.cmd("setlocal formatoptions+=t")
vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.opt_local.listchars:append({ leadmultispace = "▏ " })
