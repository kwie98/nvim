return {
    "olivercederborg/poimandres.nvim",
    enabled = false,

    config = function ()
        require("poimandres").setup()
        vim.cmd.colorscheme("poimandres")
    end
}
