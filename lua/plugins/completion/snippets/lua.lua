return {
    s("lazy", {
        t({
            "{",
            '    "url",',
            "    dependencies = {",
            '        "url_1",',
            '        "url_2",',
            "    },",
            "    lazy = true,",
            '    event = "VeryLazy",',
            '    cmd = "",',
            '    ft = "lua",',
            "    keys = {",
            '        {"lhs", mode = "n"}',
            "    },",
            "",
            "    config = function()",
            "    -- ...",
            "    end,",
            "}",
        }),
    }),
    s("S", {
        t('S.new("#'),
        i(1, "color"),
        t('", strong, weak),'),
    }),
}
