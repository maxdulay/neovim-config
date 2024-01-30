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
	"tpope/vim-surround",
	'Konfekt/vim-alias',
	"neovim/nvim-lspconfig",
	{
		'ggandor/leap.nvim',
		config = function ()
			require('leap').create_default_mappings()
		end
	},
	'hrsh7th/cmp-nvim-lsp',
	'hrsh7th/cmp-buffer',
	'hrsh7th/cmp-path',
	'hrsh7th/cmp-cmdline',
	'hrsh7th/nvim-cmp',
	--'hrsh7th/cmp-vsnip',
	--'hrsh7th/vim-vsnip',
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
		'mfussenegger/nvim-jdtls',
		ft = 'java'
	},
	-- lazy.nvim
	{
	  "folke/noice.nvim",
	  event = "VeryLazy",
	  opts = {
	    -- add any options here
	  },
	  dependencies = {
	    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
	    "MunifTanjim/nui.nvim",
	    -- OPTIONAL:
	    --   `nvim-notify` is only needed, if you want to use the notification view.
	    --   If not available, we use `mini` as the fallback
	    "rcarriga/nvim-notify",
	   }
 	},
	'tpope/vim-surround',
	'tpope/vim-fugitive',
	'tpope/vim-eunuch',
	'ThePrimeagen/vim-be-good',
	'nvim-lualine/lualine.nvim',
	'nvim-tree/nvim-web-devicons',
	'goolord/alpha-nvim',
	'lukas-reineke/indent-blankline.nvim',
	{
		'akinsho/bufferline.nvim',
		version = "*", 
		dependencies = 'nvim-tree/nvim-web-devicons',
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
	    -- Required.
	    "nvim-lua/plenary.nvim",
	    "nvim-telescope/telescope.nvim"
	    -- see below for full list of optional dependencies 👇
    }
	},
	{
		"iurimateus/luasnip-latex-snippets.nvim",
		dependencies = {"L3MON4D3/LuaSnip", 'saadparwaiz1/cmp_luasnip'},
		ft = "markdown",
		config = function()
			require('luasnip-latex-snippets').setup({ 
				use_treesitter = true,
				allow_on_markdown = true,
			})
			local ls = require("luasnip")
			local s = ls.snippet
		        local i = ls.insert_node
			local fmta = require("luasnip.extras.fmt").fmta
			local utils = require("luasnip-latex-snippets.util.utils")
			local not_math = utils.with_opts(utils.not_math, false) -- when using treesitter, change false to true

			ls.add_snippets("tex", {
				s({trig = "mk", snippetType="autosnippet", priority=100},
				  fmta("$<>$<>", { i(1), i(2), }), {condition = not_math}
				),
			})  
			require('luasnip').config.setup { enable_autosnippets = true }
		end,
	},

	{
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = {},}
	
}	)
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_snipmate").lazy_load()
require("obsidian-config")
require("luasnip-config")
require("lsp-config")
require("ibl").setup()
--require('nvim-treesitter')
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


