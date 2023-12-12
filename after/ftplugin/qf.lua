-- vim.keymap.del("n", "<Enter>", { buffer = true })
vim.keymap.set("n", "<Enter>", "<Enter><C-w>p", { buffer = true, noremap = true })
