vim.cmd([[
    augroup _general_settings
    autocmd!
    autocmd FileType toggleterm,fugitive,qf,man,help nnoremap <silent> <buffer> q :close<CR>
    autocmd User FugitiveStageBlob setlocal readonly nomodifiable noswapfile
    autocmd FileType TelescopePrompt nnoremap <silent> <buffer> q :close!<CR>
    autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'IncSearch', timeout = 100})
    autocmd BufWinEnter * :set formatoptions-=o
    augroup end

    augroup _cursor_line
    autocmd!
    autocmd VimEnter * setlocal winhighlight+=CursorLine:CursorLineCurrent
    autocmd WinEnter * setlocal winhighlight+=CursorLine:CursorLineCurrent
    autocmd BufWinEnter * setlocal winhighlight+=CursorLine:CursorLineCurrent
    autocmd WinLeave * setlocal winhighlight-=CursorLine:CursorLineCurrent
    augroup end

    augroup _titlestring
    autocmd!
    autocmd BufWinEnter * :set titlestring=%{substitute(getcwd(),\ $HOME,\ '~',\ '')}
    augroup end

    augroup _fugitive
    autocmd!
    autocmd User FugitiveIndex nnoremap <buffer> S <CMD>Git add .<CR>
    augroup end

    augroup _auto_resize
    autocmd!
    autocmd VimResized * tabdo wincmd =
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
        sign define codeblock linehl=codeBlockBackground
        augroup code_block_background
            autocmd! * <buffer>
            autocmd InsertLeave <buffer> call s:place_signs()
            autocmd BufEnter <buffer> call s:place_signs()
            autocmd BufWritePost <buffer> call s:place_signs()
        augroup END
    endfunction
]])

-- No accidental changing of environment source code:
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    group = vim.api.nvim_create_augroup("conda_nomodifiable", { clear = true }),
    pattern = "/home/konrad/.local/share/conda/envs/**",
    callback = function()
        vim.bo.modifiable = false
    end,
})
