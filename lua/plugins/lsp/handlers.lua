local M = {}

M.on_attach = function(_, _) -- client, bufnr
    -- print(vim.inspect(client.id))
    -- print(vim.inspect(client.name))
    -- print(vim.inspect(client.server_capabilities.semanticTokensProvider))
    local telescope = require("telescope.builtin")

    -- Semantic tokens are laggier than treesitter only, and mess up my rust highlights. might be nice in lua tho?
    -- client.server_capabilities.semanticTokensProvider = nil
    -- vim.opt.formatexpr = ""

    local function format_and_organize_imports()
        vim.lsp.buf.format()
        -- vim.lsp.buf.code_action({
        --     apply = true,
        --     context = {
        --         only = { "source.organizeImports" },
        --         diagnostics = {},
        --     },
        -- })
    end

    vim.keymap.set("n", "<Leader>la", vim.lsp.buf.code_action, { buffer = true, desc = "Code Action" })
    vim.keymap.set("n", "<Leader>lf", format_and_organize_imports, { buffer = true, desc = "Format" })
    vim.keymap.set("n", "<Leader>ll", vim.lsp.codelens.run, { buffer = true, desc = "CodeLens Action" })
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = true, desc = "Goto Declaration" })
    vim.keymap.set("n", "gd", telescope.lsp_definitions, { buffer = true, desc = "Goto Definition" })
    vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { buffer = true, desc = "Goto Implementation" })
    vim.keymap.set("n", "gr", telescope.lsp_references, { buffer = true, desc = "Goto References" })
    vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, { buffer = true, desc = "Signature Help" })
    vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { buffer = true, desc = "Signature Help" })
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = true, desc = "LSP Hover" })

    local filter_f_symbols = { symbols = { "function", "method", "class" } }
    vim.keymap.set(
        "n",
        "<Leader>lm",
        function() telescope.lsp_dynamic_workspace_symbols(filter_f_symbols) end,
        { buffer = true, desc = "Workspace Methods" }
    )
    -- local filter_c_symbols = { symbols = { "constant" } }
    -- vim.keymap.set("n", "<Leader>lc", function()
    --     telescope.lsp_dynamic_workspace_symbols(filter_c_symbols)
    -- end, { buffer = true, desc = "Workspace Constants" })

    vim.keymap.set("n", "<Leader>ss", telescope.lsp_document_symbols, { buffer = true, desc = "Document Symbols" })
    vim.keymap.set(
        "n",
        "<Leader>sS",
        telescope.lsp_dynamic_workspace_symbols,
        { buffer = true, desc = "Workspace Symbols" }
    )
    vim.keymap.set(
        "n",
        "<Leader>sd",
        function() telescope.diagnostics({ bufnr = 0 }) end,
        { buffer = true, desc = "Document Diagnostics" }
    )
    vim.keymap.set("n", "<Leader>sD", telescope.diagnostics, { buffer = true, desc = "Workspace Diagnostics" })
end

return M
