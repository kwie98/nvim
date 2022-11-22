local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

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
    use("wbthomason/packer.nvim")
    use("nvim-lua/plenary.nvim")
    use("windwp/nvim-autopairs")
    use("numToStr/Comment.nvim")
    use("JoosepAlviste/nvim-ts-context-commentstring")
    use("kyazdani42/nvim-web-devicons")
    use("kyazdani42/nvim-tree.lua")
    use("akinsho/bufferline.nvim")
    use("moll/vim-bbye")
    use("nvim-lualine/lualine.nvim")
    use("akinsho/toggleterm.nvim")
    use("ahmedkhalf/project.nvim")
    use("lewis6991/impatient.nvim")
    use("folke/which-key.nvim")

    -- Colorschemes
    use("sainnhe/gruvbox-material")
    use("luisiacc/gruvbox-baby")
    use("NTBBloodbath/doom-one.nvim")
    use("EdenEast/nightfox.nvim")
    use("Mofiqul/vscode.nvim")

    -- Cmp
    use("hrsh7th/nvim-cmp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("saadparwaiz1/cmp_luasnip")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-cmdline")
    use("dmitmel/cmp-cmdline-history")
    use("rcarriga/cmp-dap")
    use("ray-x/cmp-treesitter")

    -- Snippets
    use("L3MON4D3/LuaSnip")
    use("rafamadriz/friendly-snippets")

    -- LSP
    use("williamboman/mason.nvim")
    use("williamboman/mason-lspconfig.nvim")
    use("neovim/nvim-lspconfig")

    -- language specific LSP plugins
    use("b0o/SchemaStore.nvim")
    use("jose-elias-alvarez/null-ls.nvim")

    -- Telescope
    use("nvim-telescope/telescope.nvim")
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

    -- Treesitter
    use("nvim-treesitter/nvim-treesitter")
    use("nvim-treesitter/playground")
    use( "nvim-treesitter/nvim-treesitter-textobjects" )
    use( "nvim-treesitter/nvim-treesitter-context" )
    use("andymass/vim-matchup")
    use("kylechui/nvim-surround")
    use( "danymat/neogen" )
    use( "mfussenegger/nvim-treehopper" )

    -- Git
    use("lewis6991/gitsigns.nvim")
    use("tpope/vim-fugitive")
    -- use("TimUntersberger/neogit")
    -- use("sindrets/diffview.nvim")

    -- Rice
    use("ray-x/lsp_signature.nvim") -- shows function parameter information when typing
    use("NvChad/nvim-colorizer.lua")
    use("stevearc/dressing.nvim")
    use("petertriho/nvim-scrollbar")

    -- The Pope
    use("tpope/vim-repeat")

    -- Vimwiki and other Markdown things
    use( "renerocksai/telekasten.nvim" )
    use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install" })

    -- DAP
    use("mfussenegger/nvim-dap")
    use("mfussenegger/nvim-dap-python")
    use("rcarriga/nvim-dap-ui")
    use("nvim-telescope/telescope-dap.nvim")

    -- file navigation
    use("ThePrimeagen/harpoon")
    use("farmergreg/vim-lastplace")

    -- jupyter notebooks
    use("untitled-ai/jupyter_ascending.vim")
    -- use("jpalardy/vim-slime")
    -- use("hanschen/vim-ipython-cell")
    use("kana/vim-textobj-user")
    -- use("GCBallesteros/vim-textobj-hydrogen")

    if packer_bootstrap then
        require("packer").sync()
    end
end)
