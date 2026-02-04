local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set("n", "K", function() vim.cmd.RustLsp({ "hover", "actions" }) end, { buffer = bufnr })
vim.keymap.set("n", "<leader>k", function() vim.cmd.RustLsp({ "renderDiagnostic", "current" }) end, { buffer = bufnr })
vim.keymap.set("n", "]d", function() vim.cmd.RustLsp({ "renderDiagnostic", "cycle" }) end, { buffer = bufnr })
vim.keymap.set(
    "n",
    "[d",
    function() vim.cmd.RustLsp({ "renderDiagnostic", "cycle_prev" }) end,
    { buffer = bufnr }
)
