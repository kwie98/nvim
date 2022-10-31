vim.keymap.set("n", "<Enter>", "<C-]>", { buffer = true })
vim.cmd([[
    nnoremap <buffer> <Tab> /\|\zs\S\{-}\|/<cr>
    nnoremap <buffer> <S-Tab> ?\|\zs\S\{-}\|?<cr>
]])

-- vim.bo.buflisted = true
vim.wo.conceallevel = 0
