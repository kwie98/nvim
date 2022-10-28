-- require("core.lsp.configs")
-- require("core.lsp.handlers").setup()
require("core.lsp.null-ls")
require("core.lsp.diagnostic")
local function setup(mason, index, mason_lspconfig, lspconfig, nlspsettings, cmp_nvim_lsp)
    index["pydocstyle[toml]"] = "core.mason.pydocstyle-toml"

    mason.setup({
        ui = {
            border = U.big_border,
            keymaps = {
                apply_language_filter = "f",
            },
        },
    })

    mason_lspconfig.setup()

    nlspsettings.setup({
        config_home = vim.fn.stdpath("config") .. "/nlsp-settings",
        local_settings_dir = ".nlsp-settings",
        local_settings_root_markers_fallback = { ".git" },
        append_default_schemas = true,
        loader = "json",
    })

    local function on_attach(_, bufnr)
        local function buf_set_option(...)
            vim.api.nvim_buf_set_option(bufnr, ...)
        end

        buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
        local opts = { buffer = true, noremap = true, silent = true }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gd", "<CMD>Telescope lsp_definitions theme=ivy<CR>", opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gI", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "gr", "<CMD>Telescope lsp_references theme=ivy<CR>", opts)
        vim.opt.formatexpr = "" -- not sure what this is for
    end

    local global_capabilities = vim.lsp.protocol.make_client_capabilities()
    global_capabilities.textDocument.completion.completionItem.snippetSupport = true
    global_capabilities = cmp_nvim_lsp.default_capabilities(global_capabilities)

    lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
        capabilities = global_capabilities,
    })

    mason_lspconfig.setup_handlers({
        function(server)
            lspconfig[server].setup({
                on_attach = on_attach,
            })
            -- server:setup({
            --     on_attach = on_attach,
            -- })
        end,
    })
end

U.load({ "mason", "mason-registry.index", "mason-lspconfig", "lspconfig", "nlspsettings", "cmp_nvim_lsp" }, setup)
