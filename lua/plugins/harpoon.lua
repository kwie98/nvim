local status_ok, harpoon = pcall(require, "harpoon")
if not status_ok then
    print("Could not load harpoon.")
    return
end

harpoon.setup()
