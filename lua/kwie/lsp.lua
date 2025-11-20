-- vim.lsp.config("emmet_language_server", {
--     filetypes = { "xml" },
--     init_options = {
--         -- ---@type table<string, string>
--         -- includeLanguages = {},
--         -- --- @type string[]
--         -- excludeLanguages = {},
--         -- --- @type string[]
--         -- extensionsPath = {},
--         -- --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/preferences/)
--         -- preferences = {},
--         --- @type boolean Defaults to `true`
--         showAbbreviationSuggestions = true,
--         --- @type "always" | "never" Defaults to `"always"`
--         showExpandedAbbreviation = "always",
--         --- @type boolean Defaults to `false`
--         showSuggestionsAsSnippets = false,
--         -- --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/syntax-profiles/)
--         -- syntaxProfiles = {},
--         -- --- @type table<string, string> [Emmet Docs](https://docs.emmet.io/customization/snippets/#variables)
--         -- variables = {},
--     },
-- })
-- vim.lsp.config("*", {
--     on_attach = function(client, bufnr) require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr) end,
-- })
-- vim.lsp.config("emmet_ls", {
--     filetypes = { "xml" },
-- })
vim.lsp.config("jsonls", {
    settings = {
        json = {
            validate = {
                enable = true,
            },
        },
    },
    before_init = function(_, config)
        -- can't assign new table because of
        -- https://github.com/neovim/neovim/issues/27740#issuecomment-1978629315
        config.settings.json.schemas = require("schemastore").json.schemas()
    end,
})
vim.lsp.config("markdown_oxide", {
    capabilities = {
        workspace = {
            didChangeWatchedFiles = {
                dynamicRegistration = true,
            },
        },
    },
})
vim.lsp.enable("markdown_oxide")

-- vim.lsp.enable("lemminx")
vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            hint = { enable = true },
        },
    },
})
vim.lsp.enable("lua_ls")
vim.lsp.config("basedpyright", {
    settings = {
        basedpyright = {
            analysis = {
                -- Needed even with workspace-diagnostics plugin:
                diagnosticMode = "workspace",
                -- Trying to make imports of unused pip packages work, no success:
                -- autoSearchPaths = true,
                -- useLibraryCodeForTypes = true,
            },
        },
    },
})
vim.lsp.enable("basedpyright")
vim.lsp.enable("ruff")
vim.lsp.enable("jsonls")
vim.lsp.enable("yamlls")
vim.lsp.enable("emmet_language_server")
vim.lsp.enable("lemminx")
-- vim.lsp.enable("emmet_ls")
vim.lsp.enable("taplo")
local inlayHints = {
    -- includeInlayParameterNameHints = "all",
    includeInlayParameterNameHintsWhenArgumentMatchesName = false,
    includeInlayFunctionParameterTypeHints = true,
    includeInlayVariableTypeHints = true,
    includeInlayVariableTypeHintsWhenTypeMatchesName = false,
    includeInlayPropertyDeclarationTypeHints = true,
    includeInlayFunctionLikeReturnTypeHints = true,
    includeInlayEnumMemberValueHints = true,
}
vim.lsp.config("ts_ls", {
    settings = {
        typescript = {
            inlayHints = inlayHints,
        },
        javascript = {
            inlayHints = inlayHints,
        },
    },
})
vim.lsp.enable("ts_ls")
vim.lsp.config("tailwindcss", {
    cmd = { "npx", "tailwindcss-language-server", "--stdio" },
})
vim.lsp.enable("tailwindcss")

vim.lsp.enable("rust_analyzer")
vim.lsp.enable("svelte")
