U.load({ "nvim-surround" }, function(surround)
    surround.setup({
        keymaps = {
            visual = "s",
            visual_line = "gs",
        },
    })
end)
