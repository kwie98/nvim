-- Redirect command output to buffer:
vim.api.nvim_create_user_command("Redir", function(ctx)
    local lines = vim.split(vim.api.nvim_exec(ctx.args, true), "\n", { plain = true })
    vim.cmd("new")
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
    vim.opt_local.modified = false
end, { nargs = "+", complete = "command" })

-- j/k move in wrapped lines, but not when jumping multiple lines:
vim.keymap.set("n", "j", function()
    if vim.v.count == 0 then return "gj" end
    return "j"
end, { expr = true })
vim.keymap.set("n", "k", function()
    if vim.v.count == 0 then return "gk" end
    return "k"
end, { expr = true })

-- Wiki:
local wiki_index = vim.fn.expand("~/Sync/wiki/README.md")
vim.keymap.set("n", "<Leader>W", function() vim.cmd.edit(wiki_index) end, { desc = "Wiki" })

-- Quickfix:
vim.keymap.set("n", "+", function()
    if vim.bo.buftype == "quickfix" then
        vim.cmd("cclose")
        return
    end
    vim.cmd("copen")
end, { desc = "Quickfix" })
vim.keymap.set("n", "]l", "<CMD>cnext<Enter>")
vim.keymap.set("n", "[l", "<CMD>cprev<Enter>")

-- Easier matching paren:
vim.keymap.set({ "n", "x", "o" }, "m", "%")
vim.keymap.set({ "n", "x", "o" }, "%", "m")

-- Windows:
vim.keymap.set("n", "<C-j>", "<C-w>w")
vim.keymap.set("n", "<C-k>", "<C-w>W")

vim.keymap.set("n", "<C-A-h>", "<C-w>H")
vim.keymap.set("n", "<C-A-j>", "<C-w>J")
vim.keymap.set("n", "<C-A-k>", "<C-w>K")
vim.keymap.set("n", "<C-A-l>", "<C-w>L")

-- Fast file saving and quitting:
vim.keymap.set("n", "<Leader>w", "<CMD>w<Enter>", { desc = "Write" })
vim.keymap.set("n", "<Leader>q", "<CMD>q<Enter>", { desc = "Quit" })

-- Tabs:
vim.keymap.set("n", "<C-h>", "<CMD>tabprevious<Enter>")
vim.keymap.set("n", "<C-l>", "<CMD>tabnext<Enter>")
vim.keymap.set("n", "<C-w>t", "<CMD>tabnew %<Enter>")

-- Move text:
vim.keymap.set("n", "<A-j>", "<Esc>:m .+1<CR>==")
vim.keymap.set("n", "<A-k>", "<Esc>:m .-2<CR>==")
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<A-S-j>", "o<Esc>k")
vim.keymap.set("n", "<A-S-k>", "O<Esc>j")

-- Easy macros:
vim.keymap.set("n", "Q", "@qj")
vim.keymap.set("x", "Q", ":norm @q<Enter>")

-- Resize:
vim.keymap.set("n", "<C-Up>", ":resize -2<Enter>")
vim.keymap.set("n", "<C-Down>", ":resize +2<Enter>")
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<Enter>")
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<Enter>")

-- Merging binds similar to do and dp:
vim.cmd([[
    nnoremap dh :diffget //2/<c-r>=expand('%:t') <CR><CR>
    nnoremap dl :diffget //3/<c-r>=expand('%:t') <CR><CR>
]])

-- Remember positions in jumplist:
vim.keymap.set("n", "<C-u>", "m'<C-u>")
vim.keymap.set("n", "<C-d>", "m'<C-d>")

-- Utility:
vim.keymap.set("n", "gp", "`[v`]")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<Leader>n", function()
    vim.cmd(':let @/ = ""') -- clear the search register
end, { desc = "Toggle Search Highlight" })
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("n", "<", "<<")
vim.keymap.set("n", ">", ">>")
vim.keymap.set("n", "gf", "gF")

-- One-handed copy paste:
vim.keymap.set({ "i", "c" }, "<C-v>", "<C-r><C-o>+")
vim.keymap.set("s", "<C-c>", "<Esc>gvygv<C-g>")
vim.keymap.set("s", "<C-v>", "<C-r>_<Del>i<C-r>+<Esc>")
vim.keymap.set("c", "<Tab>", "<End>")

-- Diagnostics binds:
vim.keymap.set("n", "<Leader>ld", vim.diagnostic.open_float, { desc = "Show Diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)

-- Toggle diagnostic highlighting:
vim.g.diagnostic_visible = true
vim.keymap.set("n", "<Leader>lh", function()
    if vim.g.diagnostic_visible then
        vim.diagnostic.config({ virtual_text = false, underline = false })
        vim.g.diagnostic_visible = false
    else
        vim.diagnostic.config({ virtual_text = true, underline = true })
        vim.g.diagnostic_visible = true
    end
end, { desc = "Toggle Diagnostics" })

if vim.fn.has("nvim-0.9") == 1 then vim.keymap.set("n", "<Leader>lc", vim.show_pos, { desc = "Inspect Highlight" }) end
