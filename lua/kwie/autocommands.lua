vim.cmd([[
    augroup _general_settings
    autocmd!
    autocmd User FugitiveStageBlob setlocal readonly nomodifiable noswapfile
    autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'IncSearch', timeout = 100})
    autocmd BufWinEnter * :set formatoptions-=ro
    autocmd BufEnter * if &ft ==# 'help' | :vertical resize 79 | endif
    augroup end

    augroup _read_file_after_git_hook
    autocmd!
    autocmd WinEnter * checktime

    augroup _cursor_line
    autocmd!
    autocmd VimEnter * setlocal winhighlight+=CursorLine:CursorLineCurrent
    autocmd WinEnter * setlocal winhighlight+=CursorLine:CursorLineCurrent
    autocmd BufWinEnter * setlocal winhighlight+=CursorLine:CursorLineCurrent
    autocmd WinLeave * setlocal winhighlight-=CursorLine:CursorLineCurrent
    augroup end

    augroup _fugitive
    autocmd!
    autocmd User FugitiveIndex nnoremap <buffer> S <CMD>Git add .<CR>
    autocmd User FugitiveIndex nmap <buffer> <Tab> dd<C-w>b
    augroup end

    function! AutoResizeAllTabs()
        let current_tab = tabpagenr()
        tabdo wincmd =
        execute 'tabnext' current_tab
    endfunction

    augroup _auto_resize
    autocmd!
    autocmd VimResized * :call AutoResizeAllTabs()
    augroup end

    augroup _telescope_number
    autocmd!
    autocmd User TelescopePreviewerLoaded setlocal number
    augroup end

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
    pattern = "oil_preview",
    callback = function(params)
        vim.keymap.set("n", "<Enter>", "o", { buffer = params.buf, remap = true, nowait = true })
    end,
})

-- No accidental changing of environment source code:
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    group = vim.api.nvim_create_augroup("conda_nomodifiable", { clear = true }),
    pattern = "/home/konrad/.local/share/conda/envs/**",
    callback = function() vim.bo.modifiable = false end,
})

-- Set indent guides based on settings:
-- local function set_leadmultispace()
--     local spaces = "▏       "
--     if vim.bo.tabstop <= spaces:len() and not (vim.bo.filetype == "markdown") then
--         -- + 2 because the vertical line is unicode and has length 3
--         vim.opt_local.listchars:append({ leadmultispace = spaces:sub(1, vim.bo.tabstop + 2) })
--     end
-- end
-- vim.api.nvim_create_autocmd(
--     "OptionSet",
--     { pattern = { "listchars", "tabstop", "filetype" }, callback = set_leadmultispace }
-- )
-- vim.api.nvim_create_autocmd({ "BufRead" }, { callback = set_leadmultispace })

-- Update heirline:
vim.api.nvim_create_autocmd({ "BufEnter", "LspAttach", "LspDetach" }, { command = "redrawstatus" })
vim.cmd([[
    autocmd User GitSignsUpdate redrawstatus
]])
