vim.keymap.set("n", "<Leader>x", "<CMD>!python %<CR>", { buffer = true, silent = true, desc = "Execute File" })
-- vim.keymap.set("n", "<Leader>X", "<Plug>JupyterExecuteAll", { buffer = true, silent = true })
local telescope = require("telescope")
vim.keymap.set(
    "n",
    "<Leader>le",
    telescope.extensions.conda.conda,
    { buffer = true, silent = true, desc = "Environments" }
)
