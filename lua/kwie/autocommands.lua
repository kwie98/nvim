local augroup = require("kwie.util").augroup

vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup("highlight_yank"),
    callback = function() vim.highlight.on_yank({ timeout = 50 }) end,
})

-- vim.api.nvim_create_autocmd({ "BufRead", "BufNew", "BufNewFile" }, {
--     group = augroup("ft_detect"),
--     pattern = ".envrc",
--     callback = function() vim.bo.ft = "sh" end,
-- })

-- vim.api.nvim_create_autocmd({ "BufRead", "BufNew", "BufNewFile" }, {
--     group = augroup("dcmdump"),
--     pattern = ".dcm",
--     callback = function() vim.bo.ft = "dcm" end,
-- })

vim.filetype.add({
    extension = { dcm = "dcm" },
})

vim.cmd([[
    "augroup dcm_dcmdump
    "au!
    "au BufReadPre  *.dcm let &dcm=1
    "au BufReadPre *.dcm if &dcm | %!dcmdump %
    "au BufReadPost *.dcm set ft=xxd | endif
    "augroup END

    augroup bin_xxd
    au!
    au BufReadPre  *.bin let &bin=1
    au BufReadPost *.bin if &bin | %!xxd
    au BufReadPost *.bin set ft=xxd | endif
    au BufWritePre *.bin if &bin | %!xxd -r
    au BufWritePre *.bin endif
    au BufWritePost *.bin if &bin | %!xxd
    au BufWritePost *.bin set nomod | endif
    augroup END
]])

vim.api.nvim_create_autocmd("BufWinEnter", {
    group = augroup("formatoptions"),
    command = "set formatoptions-=ro",
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

-- local cursorline_group = augroup("cursorline")
-- vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter", "BufWinEnter" }, {
--     group = cursorline_group,
--     command = "setlocal winhighlight+=CursorLine:CursorLineCurrent",
-- })
-- vim.api.nvim_create_autocmd("WinLeave", {
--     group = cursorline_group,
--     command = "setlocal winhighlight-=CursorLine:CursorLineCurrent",
-- })

-- Confirm oil.nvim actions with <Enter>:
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("oil"),
    pattern = "oil_preview",
    callback = function(params)
        vim.keymap.set("n", "<Enter>", "o", { buffer = params.buf, remap = true, nowait = true })
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
