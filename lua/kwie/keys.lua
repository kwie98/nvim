local opts = { noremap = true, silent = true }

-- Navigation:
vim.keymap.set("n", "<C-j>", "<C-w>w", opts)
vim.keymap.set("n", "<C-k>", "<C-w>W", opts)
vim.keymap.set("n", "<C-l>", "<CMD>BufferLineCycleNext<CR>", opts)
vim.keymap.set("n", "<C-h>", "<CMD>BufferLineCyclePrev<CR>", opts)
vim.keymap.set("n", "<C-S-H>", "<CMD>tabprevious<CR>", opts)
vim.keymap.set("n", "<C-S-L>", "<CMD>tabnext<CR>", opts)

-- Move text:
vim.keymap.set("n", "<A-j>", "<Esc>:m .+1<CR>==", opts)
vim.keymap.set("n", "<A-k>", "<Esc>:m .-2<CR>==", opts)
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- Resize:
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Merging binds similar to do and dp:
vim.cmd([[
    nnoremap dh :diffget //2/<c-r>=expand('%:t') <CR><CR>
    nnoremap dl :diffget //3/<c-r>=expand('%:t') <CR><CR>
]])

-- Utility:
vim.keymap.set("n", "gp", "`[v`]", opts)
vim.keymap.set("n", "J", "mzJ`z", opts) -- keep cursor static
vim.keymap.set("n", "<Leader>n", "<CMD>noh<CR>", opts)
vim.keymap.set("n", "<C-u>", "<CMD>execute 'keepjumps norm! ' . '<C-u>'<CR>", opts)
vim.keymap.set("n", "<C-d>", "<CMD>execute 'keepjumps norm! ' . '<C-d>'<CR>", opts)
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)
vim.keymap.set("v", "p", '"_dP', opts) -- keep paste buffer content when overwriting something in visual mode

-- One-handed copy paste:
vim.keymap.set({ "i", "c" }, "<C-v>", "<C-r><C-o>+", opts)
vim.keymap.set("s", "<C-c>", "<Esc>gvygv<C-g>", opts)
vim.keymap.set("s", "<C-v>", "<C-r>_<Del>i<C-r>+<Esc>", opts)

-- LSP/diagnostics binds:
vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "]l", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "[l", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "<Leader>lh", function()
    if vim.g.diagnostics_visible then
        vim.diagnostic.hide()
        vim.g.diagnostics_visible = false
    else
        vim.diagnostic.show()
        vim.g.diagnostics_visible = true
    end
end, { desc = "Toggle Diagnostics" })

if vim.fn.has("nvim-0.9") == 1 then
    vim.keymap.set("n", "<Leader>lH", vim.show_pos, { desc = "Inspect Highlight" })
end

-- Swaps for neoqwertz:
vim.keymap.set({ "n", "x", "o" }, "^", "#", opts)
vim.keymap.set({ "n", "x", "o" }, "$", "^", opts) -- first symbol in line
vim.keymap.set({ "n", "x", "o" }, "|", "$", opts) -- last symbol in line
vim.keymap.set({ "n", "x", "o" }, "#", "", opts) -- free command
vim.keymap.set("n", "s", "ge", opts)

-- Mnemonics for surround:
vim.keymap.set({ "x", "o" }, "ir", "i[")
vim.keymap.set({ "x", "o" }, "ar", "a[")
vim.keymap.set({ "x", "o" }, "ia", "i<")
vim.keymap.set({ "x", "o" }, "aa", "a<")
