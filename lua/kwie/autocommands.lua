local augroup = require("kwie.util").augroup

vim.api.nvim_create_autocmd({ "BufNew", "BufNewFile", "BufRead" }, {
    group = augroup("ft_detect"),
    pattern = "*.html.django",
    callback = function() vim.bo.ft = "htmldjango" end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup("highlight_yank"),
    callback = function() vim.highlight.on_yank({ timeout = 50 }) end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
    group = augroup("formatoptions"),
    command = "set formatoptions-=ro",
})

vim.api.nvim_create_autocmd("BufEnter", {
    group = augroup("help_vsplit"),
    callback = function()
        if vim.bo.ft == "help" then vim.cmd("vertical resize 80") end
    end,
})

vim.api.nvim_create_autocmd("WinEnter", {
    group = augroup("checktime"),
    callback = function() vim.cmd.checktime() end,
})

vim.api.nvim_create_autocmd("VimResized", {
    group = augroup("resize_splits"),
    callback = function()
        local current_tab = vim.fn.tabpagenr()
        vim.cmd("tabdo wincmd =")
        vim.cmd("tabnext " .. current_tab)
    end,
})

vim.api.nvim_create_autocmd("User", {
    group = augroup("telescope_number"),
    pattern = "TelescopePreviewerLoaded",
    callback = function() vim.wo.number = true end,
})

local cursorline_group = augroup("cursorline")
vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter", "BufWinEnter" }, {
    group = cursorline_group,
    command = "setlocal winhighlight+=CursorLine:CursorLineCurrent",
})
vim.api.nvim_create_autocmd("WinLeave", {
    group = cursorline_group,
    command = "setlocal winhighlight-=CursorLine:CursorLineCurrent",
})

-- Confirm oil.nvim actions with <Enter>:
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("oil"),
    pattern = "oil_preview",
    callback = function(params)
        vim.keymap.set("n", "<Enter>", "o", { buffer = params.buf, remap = true, nowait = true })
    end,
})

-- No accidental changing of imported source code:
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    group = augroup("venv_readonly"),
    pattern = "*/venv/*",
    callback = function()
        vim.bo.readonly = true
        vim.bo.modifiable = false
    end,
})

-- Update heirline:
local heirline_group = augroup("heirline")
vim.api.nvim_create_autocmd({ "BufEnter", "LspAttach", "LspDetach" }, {
    group = heirline_group,
    command = "redrawstatus",
})
vim.api.nvim_create_autocmd("User", {
    group = heirline_group,
    pattern = "GitSignsUpdate",
    command = "redrawstatus",
})
