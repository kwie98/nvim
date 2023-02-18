---@diagnostic disable: undefined-global
return {
    s("lazy", {
        t({
            "{",
            '    "',
        }),
        i(1, "url"),
        t({
            '",',
            "    dependencies = {",
            '        "url_1",',
            '        "url_2",',
            "    },",
            "    lazy = true,",
            '    event = "VeryLazy",',
            '    cmd = "",',
            '    ft = "lua",',
            "    keys = {",
            '        {"lhs", mode = "n", desc = "desc"}',
            "    },",
            "",
            "    config = function()",
            "        -- ...",
            "    end,",
            "},",
        }),
    }),
    s("S", {
        t('S.new("#'),
        i(1, "color"),
        t('", strong, weak),'),
    }),
}
