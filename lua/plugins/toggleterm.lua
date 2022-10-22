local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
    print("Could not load toggleterm.")
    return
end

toggleterm.setup({
    size = 20,
    open_mapping = "<Leader><Enter>",
    hide_numbers = true,
    -- shade_filetypes = {},
    -- shade_terminals = true,
    -- shading_factor = "1",
    start_in_insert = true,
    insert_mappings = false,
    terminal_mappings = true,
    persist_size = true,
    -- persist_mode = false,
    direction = "horizontal",
    close_on_exit = true,
    shell = "fish",
    float_opts = {
        border = "curved",
        winblend = 0,
        highlights = {
            border = "Normal",
            background = "Normal",
        },
    },
})

function _G.set_terminal_keymaps()
    local opts = { buffer = true, noremap = true }
    vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
    -- vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
    -- vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
    -- vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
    -- vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
    -- vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd w<CR>]], opts)
    vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd W<CR>]], opts)
    -- vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

local Terminal = require("toggleterm.terminal").Terminal

local full = Terminal:new({
    direction = "tab",
    hidden = true,
})
vim.keymap.set({ "n", "t" }, "<Leader><S-Enter>", function()
    full:toggle()
end, { noremap = true, desc = "Terminal Tab" })

local function go_to_file()
    local cursor = vim.api.nvim_win_get_cursor(0)
    local bufnr = vim.api.nvim_get_current_buf()
    toggleterm.toggle(0)
    vim.api.nvim_win_set_buf(0, bufnr)
    vim.api.nvim_win_set_cursor(0, cursor)
    vim.cmd("norm! gF")
end

vim.api.nvim_create_augroup("ToggleTerm", {})
vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "term://*toggleterm#*",
    callback = function()
        vim.keymap.set("n", "gF", go_to_file, { buffer = true })
        vim.keymap.set("n", "gf", go_to_file, { buffer = true })
    end,
    group = "ToggleTerm",
})
