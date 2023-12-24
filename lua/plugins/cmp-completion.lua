return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        -- Bracket completion:
        "windwp/nvim-autopairs",
        -- Completion sources:
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-cmdline",
        "dmitmel/cmp-cmdline-history",
        -- Snippets:
        "L3MON4D3/LuaSnip",
    },
    -- lazy = false,
    event = "VeryLazy",

    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        -- Snippet keys:
        vim.keymap.set({ "i", "s" }, "<Tab>", function()
            if luasnip.expand_or_jumpable() then return '<CMD>lua require"luasnip".expand_or_jump()<Enter>' end
            return "<End>"
        end, { expr = true })
        vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
            if luasnip.jumpable(-1) then luasnip.jump(-1) end
        end, { silent = true })
        vim.keymap.set("i", "<C-l>", function()
            if luasnip.choice_active() then luasnip.change_choice(1) end
        end)

        local function is_dap_buffer(bufnr)
            local filetype = vim.api.nvim_buf_get_option(bufnr or 0, "filetype")
            if vim.startswith(filetype, "dapui_") then return true end
            if filetype == "dap-repl" then return true end

            return false
        end

        cmp.setup({
            -- For cmp-dap:
            enabled = function() return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt" or is_dap_buffer() end,
            formatting = {
                format = function(entry, vim_item)
                    if entry.source.name ~= "nvim_lsp" then
                        if vim_item.kind ~= "Text" then
                            vim_item.kind = string.format("%s %s", vim_item.kind, entry.source.name)
                        else
                            vim_item.kind = entry.source.name
                        end
                    end
                    return vim_item
                end,
            },
            snippet = {
                expand = function(args) luasnip.lsp_expand(args.body) end,
            },
            mapping = {
                ["<C-Space>"] = cmp.mapping(cmp.mapping.complete({}), { "i", "c" }), -- open the completion menu
                ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
                ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
                ["<Left>"] = cmp.mapping(cmp.mapping.close(), { "i", "c" }),
                ["<Right>"] = cmp.mapping(
                    cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
                    { "i", "c" }
                ),
                ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
                ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
            },
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "path" },
            }, {
                { name = "buffer", max_item_count = 5 },
            }),
        })
        cmp.setup.cmdline(":", {
            sources = cmp.config.sources({
                { name = "path" },
            }, {
                { name = "cmdline", priority = 100000 }, -- first
                { name = "cmdline_history", priority = 1 }, -- second
            }),
        })
        cmp.event:on(
            "confirm_done",
            require("nvim-autopairs.completion.cmp").on_confirm_done(--[[ { map_char = { tex = "" } } ]])
        )
    end,
}
