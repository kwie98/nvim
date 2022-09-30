vim.cmd([[
    augroup _general_settings
    autocmd!
    autocmd FileType fugitive,qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR>
    autocmd FileType TelescopePrompt nnoremap <silent> <buffer> q :close!<CR>
    autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 200})
    autocmd BufWinEnter * :set formatoptions-=cro
    augroup end

    " assumes set ignorecase smartcase
    augroup _dynamic_smartcase
    autocmd!
    autocmd CmdLineEnter :set nosmartcase
    autocmd CmdLineLeave :set smartcase
    augroup END

    augroup _fugitive
    autocmd!
    autocmd User FugitiveIndex nnoremap <buffer> S <CMD>Git add .<CR>
    augroup end

    augroup _auto_resize
    autocmd!
    autocmd VimResized * tabdo wincmd =
    augroup end

    " augroup _alpha
    " autocmd!
    " autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
    " augroup end
]])

-- local opts = get_format_on_save_opts()
vim.api.nvim_create_augroup("lsp_format_on_save", {})
vim.api.nvim_create_autocmd("BufWritePre", {
    group = "lsp_format_on_save",
    -- pattern = opts.pattern,
    callback = function()
        vim.lsp.buf.formatting_sync()
        -- 	filter = function(client)
        -- 		return client.name == "null-ls"
        -- 	end,
        -- local clients = vim.tbl_values(vim.lsp.buf_get_clients())
        -- clients = vim.tbl_filter(function(client)
        -- 	return client.supports_method("textDocument/formatting")
        -- end, clients)

        -- local client = clients[1]
        -- for i = 1, #clients do
        -- 	if clients[i].name == "null-ls" then
        -- 		client = clients[i]
        -- 	end
        -- end

        -- if client == nil then
        -- 	return
        -- end

        -- client.request("textDocument/formatting", {}, nil, vim.api.nvim_get_current_buf())
        -- local params = vim.lsp.util.make_formatting_params({})
        -- local result, err = client.request_sync("textDocument/formatting", params, nil, vim.api.nvim_get_current_buf())
        -- if result and result.result then
        -- 	vim.lsp.util.apply_text_edits(result.result)
        -- elseif err then
        -- 	vim.notify("vim.lsp.buf.formatting_sync: " .. err, vim.log.levels.WARN)
        -- end
    end,
})

-- Autoformat
-- augroup _lsp
--   autocmd!
--   autocmd BufWritePre * lua vim.lsp.buf.formatting()
-- augroup end
