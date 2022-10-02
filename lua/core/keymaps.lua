local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name

--Remap space as leader key
vim.keymap.set("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- NORMAL --
-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

-- Tab navigation
vim.keymap.set("n", "<C-S-H>", "<CMD>tabprevious<CR>", opts)
vim.keymap.set("n", "<C-S-L>", "<CMD>tabnext<CR>", opts)

-- Git Merging binds similar to go and gp
vim.cmd([[
    nnoremap dh :diffget //2/<c-r>=expand('%:t') <CR><CR>
    nnoremap dl :diffget //3/<c-r>=expand('%:t') <CR><CR>
]])

vim.keymap.set("n", "[h", function()
    if vim.wo.diff then
        return "[c"
    end
    vim.schedule(function()
        require("gitsigns").prev_hunk()
    end)
    return "<Ignore>"
end, { expr = true })
vim.keymap.set("n", "]h", function()
    if vim.wo.diff then
        return "]c"
    end
    vim.schedule(function()
        require("gitsigns").next_hunk()
    end)
    return "<Ignore>"
end, { expr = true })

-- Resize with arrows
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
vim.keymap.set("n", "<S-l>", "<CMD>BufferLineCycleNext<CR>", opts)
vim.keymap.set("n", "<S-h>", "<CMD>BufferLineCyclePrev<CR>", opts)

-- Explorer
-- vim.keymap.set("n", "<C-b>", "<cmd>NvimTreeToggle<cr>", opts)
-- Projects
-- vim.keymap.set("n", "<C-p>", "<CMD>lua require('telescope').extensions.projects.projects()<CR>", opts)
-- Harpoon
vim.keymap.set("n", "<Leader>u", "<CMD>lua require('harpoon.ui').nav_file(1)<CR>", opts)
vim.keymap.set("n", "<Leader>i", "<CMD>lua require('harpoon.ui').nav_file(2)<CR>", opts)
vim.keymap.set("n", "<Leader>o", "<CMD>lua require('harpoon.ui').nav_file(3)<CR>", opts)
vim.keymap.set("n", "<Leader>p", "<CMD>lua require('harpoon.ui').nav_file(4)<CR>", opts)

-- Move text up and down
vim.keymap.set("n", "<C-S-J>", "<Esc>:m .+1<CR>==", opts)
vim.keymap.set("n", "<C-S-K>", "<Esc>:m .-2<CR>==", opts)

-- keep the view (or cursor) entered
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)
vim.keymap.set("n", "J", "mzJ`z", opts)

vim.keymap.set("n", "{", "<CMD>execute 'keepjumps norm! ' . v:count1 . '{zzzv'<CR>", opts)
vim.keymap.set("n", "}", "<CMD>execute 'keepjumps norm! ' . v:count1 . '}zzzv'<CR>", opts)
vim.keymap.set("n", "<C-u>", "<CMD>execute 'keepjumps norm! ' . '<C-u>'<CR>", opts)
vim.keymap.set("n", "<C-d>", "<CMD>execute 'keepjumps norm! ' . '<C-d>'<CR>", opts)

-- DAP quick keys
vim.keymap.set("n", "<F5>", "<cmd>lua require('dap').continue()<cr>", opts)
vim.keymap.set("n", "<F6>", "<cmd>lua require('dap').close()<cr>", opts)
vim.keymap.set("n", "<F7>", "<cmd>lua require('dap').run_last()<cr>", opts)
vim.keymap.set("n", "<F8>", "<cmd>lua require('dap').step_over()<cr>", opts)
vim.keymap.set("n", "<M-k>", "<cmd>lua require('dapui').eval()<cr>", opts)
vim.keymap.set("v", "<M-k>", "<cmd>lua require('dapui').eval()<cr>", opts)

-- vim.keymap.set("n", "<Leader>j", "<CMD>cn<CR>", opts)
-- vim.keymap.set("n", "<Leader>k", "<CMD>cp<CR>", opts)
vim.keymap.set("n", "]n", "<CMD>cn<CR>", opts)
vim.keymap.set("n", "[n", "<CMD>cp<CR>", opts)
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
-- vim.keymap.set("n", "<C-q>", ":call QuickFixToggle()<CR>", opts)
vim.keymap.set("n", "<Leader>q", ":call QuickFixToggle()<CR>", opts)

-- Changing some movement keys around for neoqwertz and with illuminate
-- keymap("n", "*", "<cmd>lua require('illuminate').goto_next_reference()<cr>", opts)
-- keymap("n", "^", "<cmd>lua require('illuminate').goto_prev_reference()<cr>", opts)

vim.keymap.set({ "n", "x", "o" }, "^", "#", opts)
vim.keymap.set({ "n", "x", "o" }, "$", "^", opts) -- first symbol in line
vim.keymap.set({ "n", "x", "o" }, "|", "$", opts) -- last symbol in line
vim.keymap.set({ "n", "x", "o" }, "#", "", opts) -- free command

-- Insert --

-- typical one-handed copy paste stuff
vim.keymap.set("i", "<C-v>", "<C-r>+", opts)
vim.keymap.set("n", "<C-v>", "Pl", opts)
vim.keymap.set("x", "<C-c>", "ygv", opts)

-- Visual --
-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Move text up and down
vim.keymap.set("v", "<C-S-J>", ":m '>+1<CR>gv=gv", opts)
vim.keymap.set("v", "<C-S-K>", ":m '<-2<CR>gv=gv", opts)

-- vim.keymap.set("v", "p", '"_dP', opts)

-- in Visual, use "s" for surround just like in Normal
vim.keymap.set("x", "s", "<Plug>VSurround", opts)

-- Wildmode (Command Menu) --
vim.cmd([[
set wildcharm=<C-Z>
cnoremap <expr> <up> wildmenumode() ? "\<left>" : "\<up>"
cnoremap <expr> <down> wildmenumode() ? "\<right>" : "\<down>"
cnoremap <expr> <left> wildmenumode() ? "\<up>" : "\<left>"
cnoremap <expr> <right> wildmenumode() ? " \<bs>\<C-Z>" : "\<right>"
]])
