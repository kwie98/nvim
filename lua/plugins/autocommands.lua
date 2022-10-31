vim.cmd([[
    augroup _general_settings
    autocmd!
    autocmd FileType fugitive,qf,man nnoremap <silent> <buffer> q :close<CR>
    autocmd FileType TelescopePrompt nnoremap <silent> <buffer> q :close!<CR>
    autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 100})
    autocmd BufWinEnter * :set formatoptions-=o
    augroup end

    " " assumes set ignorecase smartcase MESSES UP :s REPLACE (could use \C)
    " augroup _dynamic_smartcase
    " autocmd!
    " autocmd CmdLineEnter : set nosmartcase
    " autocmd CmdLineLeave : set smartcase
    " augroup end

    augroup _titlestring
    autocmd!
    autocmd BufWinEnter * :set titlestring=%{substitute(getcwd(),\ $HOME,\ '~',\ '')}
    augroup end

    augroup _fugitive
    autocmd!
    autocmd User FugitiveIndex nnoremap <buffer> S <CMD>Git add .<CR>
    " autocmd User FugitiveIndex nnoremap <buffer> cc <CMD>vertical Git commit<CR> " gets overwritten by fugitive :(
    augroup end

    augroup _auto_resize
    autocmd!
    autocmd VimResized * tabdo wincmd =
    " called when doing dd or <CR> in fugitive index:
    " autocmd User FugitiveBlob 3windo vertical resize 10
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
        " setlocal signcolumn=no
        sign define codeblock linehl=codeBlockBackground
        augroup code_block_background
            autocmd! * <buffer>
            autocmd InsertLeave <buffer> call s:place_signs()
            autocmd BufEnter <buffer> call s:place_signs()
            autocmd BufWritePost <buffer> call s:place_signs()
        augroup END
    endfunction
]])


