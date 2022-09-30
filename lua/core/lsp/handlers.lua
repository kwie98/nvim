local M = {}

-- TODO: backfill this to template
M.setup = function()
    local signs = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "" },
        { name = "DiagnosticSignInfo", text = "" },
    }

    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end

    local config = {
        -- disable virtual text
        virtual_text = false,
        -- show signs
        signs = {
            active = signs,
        },
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
            focusable = false,
            style = "minimal",
            border = "none",
            source = "always",
            header = "",
            prefix = "",
        },
    }

    vim.diagnostic.config(config)

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "none",
        -- width = 60,
    })

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "none",
        -- width = 60,
    })
end

-- local function lsp_highlight_document(client)
--     -- Set autocommands conditional on server_capabilities
--     local status_ok, illuminate = pcall(require, "illuminate")
--     if not status_ok then
--         return
--     end
--     illuminate.on_attach(client)
--     -- end
-- end

local function lsp_keymaps(bufnr)
    local opts = { noremap = true, silent = true }
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<CMD>lua vim.lsp.buf.declaration()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<CMD>Telescope lsp_definitions theme=ivy<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<CMD>lua vim.lsp.buf.hover()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gI", "<CMD>lua vim.lsp.buf.implementation()<CR>", opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<CMD>lua vim.lsp.buf.signature_help()<CR>", opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<CMD>lua vim.lsp.buf.rename()<CR>", opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<CMD>lua vim.lsp.buf.references()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<CMD>Telescope lsp_references theme=ivy<CR>", opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<CMD>lua vim.lsp.buf.code_action()<CR>", opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>f", "<CMD>lua vim.diagnostic.open_float()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", '<CMD>lua vim.diagnostic.goto_prev({ border = "none" })<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gl", '<CMD>lua vim.diagnostic.open_float({ border = "none" })<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", '<CMD>lua vim.diagnostic.goto_next({ border = "none" })<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>q", "<CMD>lua vim.diagnostic.setloclist()<CR>", opts)
    -- vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format{async=true}' ]])
end

-- local formatting_callback = function(client, bufnr)
--   vim.keymap.set('n', '<leader>x', function()
--     local params = vim.lsp.util.make_formatting_params({})
--     client.request('textDocument/formatting', params, nil, bufnr)
--   end, { buffer = bufnr })
-- end

M.on_attach = function(client, bufnr)
    -- remove formatting capabilities from some servers in order to use the null-ls formatters more easily
    local non_formatters = { "tsserver", "sumneko_lua", "jsonls" }
    for _, non_formatter in pairs(non_formatters) do
        if client.name == non_formatter then
            client.resolved_capabilities.document_formatting = false
        end
    end
    lsp_keymaps(bufnr)
    -- lsp_highlight_document(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
    return
end

M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

return M
