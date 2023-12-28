---@param name string
local function augroup(name) return vim.api.nvim_create_augroup("kwie_" .. name, { clear = true }) end

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

vim.cmd([[
    " Markdown darker code blocks
    function! s:place_signs()
        let l:continue = 0
        let l:file = expand('%')
        execute 'sign unplace * file=' . l:file
        for l:lnum in range(1, line('$'))
            let l:line = getline(l:lnum)
            if l:continue || l:line =~# '^\s*```'
                execute printf('sign place %d line=%d name=codeblock file=%s', l:lnum, l:lnum, l:file)
            endif
            let l:continue = l:continue ? l:line !~# '^\s*```$' : l:line =~# '^\s*```'
        endfor
    endfunction

    function! ColorCodeBlocks() abort
        sign define codeblock linehl=CodeBlockBackground
        augroup code_block_background
            autocmd! * <buffer>
            autocmd InsertLeave <buffer> call s:place_signs()
            autocmd BufEnter <buffer> call s:place_signs()
            autocmd BufWritePost <buffer> call s:place_signs()
        augroup END
    endfunction
]])

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

-- Hide diagnostics when editing, show again after saving:
local diagnostics_group = augroup("diagnostics")
vim.api.nvim_create_autocmd({ "TextChanged", "InsertEnter" }, {
    group = diagnostics_group,
    callback = function(args) vim.diagnostic.disable(args.bug) end,
})
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    group = diagnostics_group,
    callback = function(args) vim.diagnostic.enable(args.bug) end,
})
