local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    print("Installing packer close and reopen Neovim...")
    vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
-- vim.cmd([[
--   augroup packer_user_config
--   autocmd!
--   autocmd BufWritePost packer.lua source <afile> | PackerSync
--   augroup end
-- ]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    print("Could not load packer.")
    return
end

-- Have packer use a popup window
packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({ border = U.big_border })
        end,
    },
})

return packer.startup(function(use)
    use({ "wbthomason/packer.nvim" }) -- Have packer manage itself
    use({ "nvim-lua/plenary.nvim" }) -- Useful lua functions used by lots of plugins
    use({ "windwp/nvim-autopairs" }) -- Autopairs, integrates with both cmp and treesitter
    use({ "numToStr/Comment.nvim" })
    use({ "JoosepAlviste/nvim-ts-context-commentstring" })
    use({ "kyazdani42/nvim-web-devicons" })
    use({ "kyazdani42/nvim-tree.lua" })
    use({ "akinsho/bufferline.nvim" })
    use({ "moll/vim-bbye" })
    use({ "nvim-lualine/lualine.nvim" })
    -- use({ "feline-nvim/feline.nvim" })
    use({ "akinsho/toggleterm.nvim" })
    use({ "ahmedkhalf/project.nvim" })
    use({ "lewis6991/impatient.nvim" })
    -- use({ "lukas-reineke/indent-blankline.nvim", commit = "6177a59552e35dfb69e1493fd68194e673dc3ee2" })
    -- use({ "goolord/alpha-nvim", commit = "ef27a59e5b4d7b1c2fe1950da3fe5b1c5f3b4c94" })
    use("folke/which-key.nvim")

    -- Colorschemes
    use({ "sainnhe/gruvbox-material" })
    use({ "luisiacc/gruvbox-baby" })
    use({ "NTBBloodbath/doom-one.nvim" })
    use({ "EdenEast/nightfox.nvim" })
    use({ "Mofiqul/vscode.nvim" })
    -- use({"tjdevries/gruvbuddy.nvim", requires = "tjdevries/colorbuddy.nvim"})
    -- use({ "navarasu/onedark.nvim" }) -- somehow looks better in pictures d
    -- use({ "lourenci/github-colors" })
    -- use({ "folke/tokyonight.nvim" })
    -- use({ "Everblush/everblush.nvim" })
    -- use({ "projekt0n/github-nvim-theme" })
    -- use("lunarvim/darkplus.nvim")
    -- use({ "catppuccin/nvim", as = "catppuccin" })
    -- use({
    --     "mcchrish/zenbones.nvim",
    --     requires = "rktjmp/lush.nvim",
    -- })
    -- use({ "marko-cerovac/material.nvim" })
    -- use({ "EdenEast/nightfox.nvim" })
    -- use({ "yazeed1s/minimal.nvim" })
    -- use({ "PHSix/nvim-hybrid" })

    -- cmp plugins
    use({ "hrsh7th/nvim-cmp" })

    use({ "hrsh7th/cmp-buffer" }) -- buffer word completions
    use({ "hrsh7th/cmp-path" }) -- system path completions
    use({ "saadparwaiz1/cmp_luasnip" }) -- snippet completions
    use({ "hrsh7th/cmp-nvim-lsp" })
    -- use({ "hrsh7th/cmp-nvim-lua" })
    use({ "hrsh7th/cmp-cmdline" })
    use({ "dmitmel/cmp-cmdline-history" })
    use({ "rcarriga/cmp-dap" })
    use({ "ray-x/cmp-treesitter" })
    -- use({ "hrsh7th/nvim-cmp", commit = "df6734aa018d6feb4d76ba6bda94b1aeac2b378a" }) -- The completion plugin
    -- use({ "hrsh7th/cmp-buffer", commit = "62fc67a2b0205136bc3e312664624ba2ab4a9323" }) -- buffer completions
    -- use({ "hrsh7th/cmp-path", commit = "466b6b8270f7ba89abd59f402c73f63c7331ff6e" }) -- path completions
    -- use({ "saadparwaiz1/cmp_luasnip", commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36" }) -- snippet completions
    -- use({ "hrsh7th/cmp-nvim-lsp", commit = "affe808a5c56b71630f17aa7c38e15c59fd648a8" })
    -- use({ "hrsh7th/cmp-nvim-lua", commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21" })

    -- snippets
    use({ "L3MON4D3/LuaSnip" }) --snippet engine
    use({ "rafamadriz/friendly-snippets" }) -- a bunch of snippets to use
    -- use({ "L3MON4D3/LuaSnip", commit = "79b2019c68a2ff5ae4d732d50746c901dd45603a" }) --snippet engine
    -- use({ "rafamadriz/friendly-snippets", commit = "d27a83a363e61009278b6598703a763ce9c8e617" }) -- a bunch of snippets to use

    -- LSP
    use({ "williamboman/mason.nvim" })
    use({ "williamboman/mason-lspconfig.nvim" })
    use({ "neovim/nvim-lspconfig" }) -- enable LSP
    use({ "tamago324/nlsp-settings.nvim" })

    -- language specific LSP plugins
    use({ "b0o/SchemaStore.nvim" })
    use({ "jose-elias-alvarez/null-ls.nvim" }) -- for formatters and linters

    -- Telescope
    use({ "nvim-telescope/telescope.nvim" })
    use({
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "make",
    })

    -- Treesitter
    use({ "nvim-treesitter/nvim-treesitter" })
    use({ "nvim-treesitter/playground" })
    use({ "nvim-treesitter/nvim-treesitter-textobjects" })
    -- use({ "nvim-treesitter/nvim-treesitter-context", commit = "c46a8a0a60412a8fe43aa6bd3a01845c46de6bf2" })
    use({ "nvim-treesitter/nvim-treesitter-context" })
    use({ "andymass/vim-matchup" })
    use({ "kylechui/nvim-surround" })
    use({ "danymat/neogen", requires = "nvim-treesitter/nvim-treesitter" })
    use({ "mfussenegger/nvim-treehopper", requires = "nvim-treesitter/nvim-treesitter" })

    -- Git
    use({ "lewis6991/gitsigns.nvim" })
    use({ "tpope/vim-fugitive" })

    -- Rice
    use({ "ray-x/lsp_signature.nvim" }) -- shows function parameter information when typing
    use({ "NvChad/nvim-colorizer.lua" })
    use({ "stevearc/dressing.nvim" })
    use({
        "petertriho/nvim-scrollbar",
    })

    -- The Pope
    use({ "tpope/vim-repeat" })

    -- Vimwiki and other Markdown things
    use({
        "renerocksai/telekasten.nvim",
        requires = "nvim-telescope/telescope.nvim",
    })
    use({
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
    })

    -- DAP
    use({ "mfussenegger/nvim-dap" })
    use({ "mfussenegger/nvim-dap-python" })
    use({ "rcarriga/nvim-dap-ui" })
    use({ "nvim-telescope/telescope-dap.nvim" })

    -- file navigation
    use({ "ThePrimeagen/harpoon" })
    use({ "farmergreg/vim-lastplace" })

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
