vim.keymap.set("n", "<F5>", require("rest-nvim").run, { desc = "Run Request" })
vim.keymap.set("n", "<F7>", require("rest-nvim").last, { desc = "Run Last Request" })
