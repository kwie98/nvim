local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", "<CMD>BufferLineCycleNext<CR>", opts)
keymap("n", "<S-h>", "<CMD>BufferLineCyclePrev<CR>", opts)
-- keymap("n", "<S-l>", ":bnext<CR>", opts)
-- keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Explorer
keymap("n", "<C-b>", "<cmd>NvimTreeToggle<cr>", opts)
-- Projects
keymap("n", "<C-p>", "<CMD>lua require('telescope').extensions.projects.projects()<CR>", opts)
-- Harpoon
keymap("n", "<Leader>u", "<CMD>lua require('harpoon.ui').nav_file(1)<CR>", opts)
keymap("n", "<Leader>i", "<CMD>lua require('harpoon.ui').nav_file(2)<CR>", opts)
keymap("n", "<Leader>o", "<CMD>lua require('harpoon.ui').nav_file(3)<CR>", opts)
keymap("n", "<Leader>p", "<CMD>lua require('harpoon.ui').nav_file(4)<CR>", opts)

-- Move text up and down
keymap("n", "<C-S-J>", "<Esc>:m .+1<CR>==", opts)
keymap("n", "<C-S-K>", "<Esc>:m .-2<CR>==", opts)

-- keep the view (or cursor) entered
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)
keymap("n", "J", "mzJ`z", opts)

keymap("n", "{", "{zzzv", opts)
keymap("n", "}", "}zzzv", opts)
keymap("n", "<C-u>", "<C-u>zzzv", opts)
keymap("n", "<C-d>", "<C-d>zzzv", opts)

-- DAP quick keys
keymap("n", "<F5>", "<cmd>lua require('dap').continue()<cr>", opts)
keymap("n", "<F6>", "<cmd>lua require('dap').close()<cr>", opts)
keymap("n", "<F7>", "<cmd>lua require('dap').run_last()<cr>", opts)
keymap("n", "<F8>", "<cmd>lua require('dap').step_over()<cr>", opts)
keymap("n", "<M-k>", "<cmd>lua require('dapui').eval()<cr>", opts)
keymap("v", "<M-k>", "<cmd>lua require('dapui').eval()<cr>", opts)

keymap("n", "<Leader>j", "<CMD>cn<CR>", opts)
keymap("n", "<Leader>k", "<CMD>cp<CR>", opts)
vim.cmd([[
    function! QuickFixToggle()
        if empty(filter(getwininfo(), 'v:val.quickfix'))
            copen
            wincmd p " go back to previous window
        else
            cclose
        endif
    endfunction
]])
keymap("n", "<C-q>", ":call QuickFixToggle()<CR>", opts)

-- Changing some movement keys around for neoqwertz and with illuminate
-- keymap("n", "*", "<cmd>lua require('illuminate').goto_next_reference()<cr>", opts)
-- keymap("n", "^", "<cmd>lua require('illuminate').goto_prev_reference()<cr>", opts)
keymap("n", "^", "#", opts)

keymap("n", "$", "^", opts) -- first symbol in line
keymap("n", "|", "$", opts) -- last symbol in line
keymap("n", "#", "", opts) -- free command

-- Insert --

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
-- keymap("v", "<A-j>", ":m .+1<CR>==", opts)
-- keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
-- keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
-- keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
-- keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
-- keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- in Visual, use "s" for surround just like in Normal
keymap("x", "s", "<Plug>VSurround", opts)

-- Wildmode (Command Menu) --
vim.cmd([[
set wildcharm=<C-Z>
cnoremap <expr> <up> wildmenumode() ? "\<left>" : "\<up>"
cnoremap <expr> <down> wildmenumode() ? "\<right>" : "\<down>"
cnoremap <expr> <left> wildmenumode() ? "\<up>" : "\<left>"
cnoremap <expr> <right> wildmenumode() ? " \<bs>\<C-Z>" : "\<right>"
]])

-- Terminal --
-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
