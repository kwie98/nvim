vim.g.indent_blankline_filetype_exclude = { "haskell" }

require("indent_blankline").setup({
    -- char = "▏",

    space_char_blankline = " ",
    char = "",
    char_highlight_list = {
        "IndentBlanklineIndent0",
        "IndentBlanklineIndent1",
    },
    space_char_highlight_list = {
        "IndentBlanklineIndent0",
        "IndentBlanklineIndent1",
    },
    show_trailing_blankline_indent = false,
})
