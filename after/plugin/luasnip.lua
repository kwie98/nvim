local luasnip = require("luasnip")
local types = require("luasnip.util.types")
local loader = require("luasnip.loaders.from_lua")

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

loader.lazy_load({ paths = vim.fn.stdpath("config") .. "/lua/snippets" })
