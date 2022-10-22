U.load({ "cmp", "luasnip", "luasnip.loaders.from_vscode" }, function(cmp, luasnip, luasnip_loaders_from_vscode)
    luasnip_loaders_from_vscode.lazy_load()

    local check_backspace = function()
        local col = vim.fn.col(".") - 1
        return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
    end

    --   פּ ﯟ   some other good icons
    local kind_icons = {
        Text = "",
        Method = "m",
        Function = "",
        Constructor = "",
        Field = "",
        Variable = "",
        Class = "",
        Interface = "",
        Module = "",
        Property = "",
        Unit = "",
        Value = "",
        Enum = "",
        Keyword = "",
        Snippet = "",
        Color = "",
        File = "",
        Reference = "",
        Folder = "",
        EnumMember = "",
        Constant = "",
        Struct = "",
        Event = "",
        Operator = "",
        TypeParameter = "",
    }
    -- find more here: https://www.nerdfonts.com/cheat-sheet

    cmp.setup({
        completion = {
            completeopt = "menu,menuone,noinsert",
        },
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body) -- For `luasnip` users.
            end,
        },
        mapping = {
            ["<Up>"] = cmp.mapping.select_prev_item(),
            ["<Down>"] = cmp.mapping.select_next_item(),
            ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
            ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
            -- ["<Right>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
            ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
            ["<Left>"] = cmp.mapping({
                i = cmp.mapping.abort(),
                c = cmp.mapping.close(),
            }),
            ["<C-Space>"] = cmp.mapping.complete(),
            -- Accept currently selected item. If none selected, `select` first item.
            -- Set `select` to `false` to only confirm explicitly selected items.
            ["<Right>"] = cmp.mapping.confirm({ select = true }),
            ["<Tab>"] = cmp.mapping(function(fallback)
                if luasnip.expandable() then
                    luasnip.expand()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                else
                    fallback()
                end
            end, {
                "i",
                "s",
            }),
            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, {
                "i",
                "s",
            }),
        },
        formatting = {
            fields = { "abbr", "kind" },
            format = function(entry, vim_item)
                -- Kind icons
                vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
                -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatenates the icons with the name of the item kind
                -- vim_item.menu = ({
                --     nvim_lsp = "[LSP]",
                --     luasnip = "[Snippet]",
                --     buffer = "[Buffer]",
                --     path = "[Path]",
                -- })[entry.source.name]
                return vim_item
            end,
        },
        sources = {
            { name = "nvim_lsp" },
            { name = "luasnip" },
            { name = "buffer" },
            { name = "path" },
        },
        confirm_opts = {
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
        },
        window = {
            documentation = {
                border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
            },
        },
        experimental = {
            ghost_text = false,
        },
    })
end)