local status_ok, illuminate = pcall(require, "illuminate")
if not status_ok then
    return
end

illuminate.configure({
    delay = 500,
    providers = {
        "lsp",
        "treesitter",
        -- "regex",
    },
    filetypes_denylist = {
        "dirvish",
        "fugitive",
        "NvimTree",
    },
})
