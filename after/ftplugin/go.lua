require("nvim-surround").buffer_setup({
    surrounds = {
        ["p"] = {
            add = { "fmt.Println(", ")" },
        },
    },
})
