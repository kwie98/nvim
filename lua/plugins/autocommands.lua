vim.cmd([[
    augroup _general_settings
    autocmd!
    autocmd FileType fugitive,qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR>
    autocmd FileType TelescopePrompt nnoremap <silent> <buffer> q :close!<CR>
    autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 100})
    autocmd BufWinEnter * :set formatoptions-=o
    augroup end

    " " assumes set ignorecase smartcase
    " augroup _dynamic_smartcase
    " autocmd!
    " autocmd CmdLineEnter : set nosmartcase
    " autocmd CmdLineLeave : set smartcase
    " augroup end

    augroup _fugitive
    autocmd!
    autocmd User FugitiveIndex nnoremap <buffer> S <CMD>Git add .<CR>
    augroup end

    augroup _auto_resize
    autocmd!
    autocmd VimResized * tabdo wincmd =
    augroup end

]])

-- local format_on_save = vim.api.nvim_create_augroup("_format_on_save", { clear = true })
-- vim.api.nvim_create_autocmd("BufWritePre", {
--     group = format_on_save,
--     pattern = "*",
--     callback = function()
--         vim.lsp.buf.format()
--     end,
-- })
