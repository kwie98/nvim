U.load({ "luasnip", "luasnip.util.types" }, function(luasnip, types)
    luasnip.config.set_config({
        history = true,
        updateevents = "TextChanged,TextChangedI",
        ext_opts = {
            [types.choiceNode] = {
                active = {
                    virt_text = { { " « ", "NonTest" } },
                },
            },
        },
    })

    vim.keymap.set({ "i", "s" }, "<Tab>", function()
        if luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
        end
    end, { silent = true })

    vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
        if luasnip.jumpable(-1) then
            luasnip.jump(-1)
        end
    end, { silent = true })

    vim.keymap.set("i", "<C-l>", function()
        if luasnip.choice_active() then
            luasnip.change_choice(1)
        end
    end)
end)
