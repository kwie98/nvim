local status_ok, colorizer = pcall(require, "colorizer")
if not status_ok then
    print("Could not load colorizer.")
    return
end

colorizer.setup({
    -- ["*"] = {
    --     names = false,
    -- },
    -- "!packer",
    filetypes = { "*", "!packer" },
    user_default_options = {
        names = false,
    },
})
