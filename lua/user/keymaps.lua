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

-- Tab navigation
keymap("n", "<C-S-H>", "<CMD>tabprevious<CR>", opts)
keymap("n", "<C-S-L>", "<CMD>tabnext<CR>", opts)

-- Git Merging binds similar to go and gp
vim.cmd([[
    nnoremap dh :diffget //2/<c-r>=expand('%:t') <CR><CR>
    nnoremap dl :diffget //3/<c-r>=expand('%:t') <CR><CR>
]])

-- TODO try these on 0.8
-- vim.keymap("n", "[c", function()
--     if vim.wo.diff then
--         return "[c"
--     end
--     vim.schedule(function()
--         require("gitsigns").prev_hunk()
--     end)
--     return "<Ignore>"
-- end, { expr = true })
-- vim.keymap("n", "]c", function()
--     if vim.wo.diff then
--         return "]c"
--     end
--     vim.schedule(function()
--         require("gitsigns").next_hunk()
--     end)
--     return "<Ignore>"
-- end, { expr = true })

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

--[[ keymap("n", "{", "{zzzv", opts) ]]
--[[ keymap("n", "}", "}zzzv", opts) ]]
keymap("n", "{", "<CMD>execute 'keepjumps norm! ' . v:count1 . '{zzzv'<CR>", opts)
keymap("n", "}", "<CMD>execute 'keepjumps norm! ' . v:count1 . '}zzzv'<CR>", opts)
keymap("n", "<C-u>", "<CMD>execute 'keepjumps norm! ' . '<C-u>'<CR>", opts)
keymap("n", "<C-d>", "<CMD>execute 'keepjumps norm! ' . '<C-d>'<CR>", opts)

--[[ keymap("n", "<C-u>", "<C-u>M", opts) ]]
--[[ keymap("n", "<C-d>", "<C-d>M", opts) ]]

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

keymap("x", "^", "#", opts)
keymap("x", "$", "^", opts) -- first symbol in line
keymap("x", "|", "$", opts) -- last symbol in line
keymap("x", "#", "", opts) -- free command

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
keymap("v", "<C-S-J>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<C-S-K>", ":m '<-2<CR>gv=gv", opts)

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
