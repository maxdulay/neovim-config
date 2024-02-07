local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }) end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
	-- LSP setup
	"neovim/nvim-lspconfig",
	'hrsh7th/cmp-nvim-lsp',
	'hrsh7th/cmp-buffer',
	'hrsh7th/cmp-path',
	'hrsh7th/cmp-cmdline',
	'hrsh7th/nvim-cmp',
	'L3MON4D3/LuaSnip',
	{
	      'nvim-treesitter/nvim-treesitter',
	      dependencies = "hrsh7th/nvim-cmp", 
	      build = ':TSUpdate',
	      event = { 'BufReadPre', 'BufNewFile' },
	      main = 'nvim-treesitter.configs',
	      opts = {highlight = { enable = true },}
	},
	'saadparwaiz1/cmp_luasnip',
	'williamboman/mason.nvim',
	'williamboman/mason-lspconfig.nvim',
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" }
	},
	-- Testing
	{
		"nvim-neotest/neotest",
		dependencies = {
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter"
		},
		ft = 'java'
	},
	-- Java
	{
		'mfussenegger/nvim-jdtls',
		ft = 'java'
	},
	{
		'rcasia/neotest-java',
		ft = 'java'
	},
	-- File navigation tools 
	{
	    'goolord/alpha-nvim',
	    config = function ()
		require'alpha-config'
		require'alpha'.setup(require'alpha.themes.dashboard'.config)
	    end
	},
	"preservim/nerdtree",
	{
	    'nvim-telescope/telescope.nvim', tag = '0.1.5',
	      dependencies = { 'nvim-lua/plenary.nvim' }
	},	
	-- Editing tools 
	"tpope/vim-surround",
	{
		'ggandor/leap.nvim',
		config = function ()
			require('leap').create_default_mappings()
		end
	},
	'Konfekt/vim-alias',
	'tpope/vim-fugitive',
	'tpope/vim-eunuch',
	{
	  "folke/noice.nvim",
	  event = "VeryLazy",
	  opts = {
	  },
	  dependencies = {
	    "MunifTanjim/nui.nvim",
	    "rcarriga/nvim-notify",
	   }
 	},
	-- Aesthetics 
	'nvim-lualine/lualine.nvim',
	'nvim-tree/nvim-web-devicons',
	'lukas-reineke/indent-blankline.nvim',
	{
		'akinsho/bufferline.nvim',
		version = "*", 
		dependencies = 'nvim-tree/nvim-web-devicons',
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
	{
	  "epwalsh/obsidian.nvim",
	  version = "*",  -- recommended, use latest release instead of latest commit
	  lazy = true,
	  ft = "markdown",
	  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
	  -- event = {
	  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
	  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
	  --   "BufReadPre path/to/my-vault/**.md",
	  --   "BufNewFile path/to/my-vault/**.md",
	  -- },
	  dependencies = {
		  "nvim-lua/plenary.nvim",
		  "nvim-telescope/telescope.nvim"
	  }
	},
	{
		"maxdulay/luasnip-latex-snippets.nvim",
		dependencies = {"L3MON4D3/LuaSnip", 'saadparwaiz1/cmp_luasnip'},
		ft = "markdown",
		config = function()
			require('luasnip-latex-snippets').setup({ 
				use_treesitter = true,
				allow_on_markdown = true,
			})
			require('luasnip-latex-config')
			require('luasnip').config.setup { enable_autosnippets = true }
		end,
	},

}	)
-- Configs and setups
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_snipmate").lazy_load()
require("obsidian-config")
require("luasnip-config")
require("lsp-config")
require("ibl").setup()
require("cmp").setup()
require("NERDTree-config")
require('keybindings')
require('tree-sitter')
require('lualine').setup()
require('tokyonight').setup {
	style = "night",
	transparent = vim.g.neovide == nil}
require("bufferline-config")
require("vsnip-config")
-- vim settings
vim.cmd('colorscheme tokyonight')
vim.cmd("set number")
vim.cmd("syntax on")
vim.cmd("set relativenumber")
vim.cmd("set mouse=a")
vim.cmd("set path+=**")
vim.cmd("set noswapfile")
vim.cmd("set wildmenu")
vim.cmd("set incsearch")
vim.cmd("set smartindent")
vim.cmd("set ic")
vim.cmd("set splitright")
vim.cmd("set splitbelow")
vim.cmd("set clipboard=unnamed")
vim.cmd("set clipboard=unnamedplus")
vim.cmd("set linebreak")
vim.opt.termguicolors = true


