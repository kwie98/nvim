local status_ok, nvim_surround = pcall(require, "nvim-surround")
if not status_ok then
    print("Could not load nvim-surround.")
    return
end
nvim_surround.setup()
