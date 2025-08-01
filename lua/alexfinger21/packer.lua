 return require('packer').startup(function(use)
  -- Packer manages itself
  use 'wbthomason/packer.nvim'

  -- Mason + LSP
  use("williamboman/mason.nvim")
  use("williamboman/mason-lspconfig.nvim")
  use("neovim/nvim-lspconfig")

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- Theme
  use({ "rebelot/kanagawa.nvim", as = "kanagawa", config = function() vim.cmd("colorscheme kanagawa-lotus") end })

  -- Treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate"
  })
  use("nvim-treesitter/playground")

  -- Git, navigation, utils
  use("ThePrimeagen/harpoon")
  use("mbbill/undotree")
  use("tpope/vim-fugitive")
  use("simrat39/rust-tools.nvim")

  -- Completion
  use("hrsh7th/nvim-cmp")
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-nvim-lua")
  use("hrsh7th/cmp-nvim-lsp-signature-help")
  use("hrsh7th/cmp-vsnip")
  use("hrsh7th/cmp-path")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/vim-vsnip")

  -- File Explorer
  use("alexfinger21/nvim-tree.lua")
  use("nvim-tree/nvim-web-devicons")

  -- Autopairs
  use({
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup {}
    end
  })

  -- Markdown preview
  use({
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    setup = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  })

  -- Wakatime
  use("wakatime/vim-wakatime")
end)

