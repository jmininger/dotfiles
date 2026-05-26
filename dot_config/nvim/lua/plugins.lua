return require('packer').startup(function(use)
  -- Packer can manage itself
  use "wbthomason/packer.nvim"
  use "tpope/vim-fugitive" -- Git commands
  use "tpope/vim-commentary"
  -- use "preservim/nerdtree"
  use "rust-lang/rust.vim"
  use {
    'mrcjkb/rustaceanvim',
    version = '^5',
    ft = { 'rust' },
  }
  -- use "neovimhaskell/haskell-vim"
  use {
    "mrcjkb/haskell-tools.nvim",
    version = '^4', -- Recommended
  }
  use "shinchu/lightline-gruvbox.vim"
  use { "ellisonleao/gruvbox.nvim" }
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use 'neovim/nvim-lspconfig'
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.3',
  -- or                            , branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {'nvim-telescope/telescope-ui-select.nvim' }

  -- Treesitter disabled for now due to breaking changes
  -- use {
  --   'nvim-treesitter/nvim-treesitter',
  --   run = ':TSUpdate',
  -- }
  -- use 'nvim-treesitter/playground'
  -- use({
  --   "nvim-treesitter/nvim-treesitter-textobjects",
  --   after = "nvim-treesitter",
  --   requires = "nvim-treesitter/nvim-treesitter",
  -- })

  use "NLKNguyen/papercolor-theme"
  use "lifepillar/vim-solarized8"

  -- Autocompletion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'saadparwaiz1/cmp_luasnip'
  use 'hrsh7th/cmp-nvim-lua'

  -- Snippets
  use 'L3MON4D3/LuaSnip'
  use 'rafamadriz/friendly-snippets'
  use 'puremourning/vimspector'
  use 'voldikss/vim-floaterm'
  use 'hrsh7th/cmp-nvim-lsp-signature-help'
  use 'hrsh7th/vim-vsnip'

  use "preservim/tagbar"
	use {
		"folke/trouble.nvim",
		requires = "nvim-tree/nvim-web-devicons",
		config = function()
			require("trouble").setup {
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			}
		end
	}
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  use 'github/copilot.vim'
  use 'nvim-tree/nvim-web-devicons'
  use 'iden3/vim-circom-syntax'
  use 'noir-lang/noir-nvim'
  use 'kdheepak/lazygit.nvim'
  use {
    "henriklovhaug/Preview.nvim",
    cmd = { "Preview" },
    config = function()
      require("preview").setup()
    end
  }

use 'andrew-george/telescope-themes'
use 'EdenEast/nightfox.nvim'
use 'navarasu/onedark.nvim'
use 'folke/tokyonight.nvim'
use { "catppuccin/nvim", as = "catppuccin" }
use {
  "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    }
}
use {
    'goolord/alpha-nvim',
    -- config = function ()
    --     require'alpha'.setup(require'alpha.themes.dashboard'.config)
    -- end
}

use('simrat39/inlay-hints.nvim')

use {
  'nvim-tree/nvim-tree.lua',
  requires = {
    'nvim-tree/nvim-web-devicons', -- optional
  },
}


end)
