vim.keymap.set("n", "<Leader>x", "<CMD>MarkdownPreview<CR>", { buffer = true })
vim.keymap.set("n", "<C-Space>", "<CMD>Telekasten toggle_todo<CR>", { buffer = true })
-- vim.keymap.set("n", "<Enter>", "<CMD>Telekasten follow_link<CR>", { buffer = true })
vim.keymap.set("n", "<Enter>", "<CMD>Telescope lsp_definitions theme=ivy<CR>", { buffer = true })
vim.keymap.set("n", "<Tab>", "/[[\\zs<CR>", { buffer = true })
vim.keymap.set("n", "<S-Tab>", "?[[\\zs<CR>", { buffer = true })

vim.opt.wrap = true
vim.opt.spell = true
vim.opt.textwidth = 100
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
