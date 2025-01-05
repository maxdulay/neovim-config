--
-- Example for configuring Neovim to load user-installed installed Lua rocks:
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
	{
		'glacambre/firenvim',
		-- Lazy load firenvim
		-- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
		lazy = not vim.g.started_by_firenvim,
		build = function()
			vim.fn["firenvim#install"](0)
		end
	},
	{
		'mikesmithgh/kitty-scrollback.nvim',
		enabled = true,
		lazy = true,
		cmd = { 'KittyScrollbackGenerateKittens', 'KittyScrollbackCheckHealth' },
		event = { 'User KittyScrollbackLaunch' },
		config = function()
			require('kitty-scrollback').setup()
		end,
	},
	{
		'neovim/nvim-lspconfig',
		dependencies = { 'saghen/blink.cmp', },

		-- example using `opts` for defining servers
		opts = {
			servers = {
				lua_ls = {
					settings = {
						Lua = {
							runtime = {
								-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
								version = "LuaJIT",
								path = vim.split(package.path, ";"),
							},
							diagnostics = {
								-- Get the language server to recognize the `vim` global
								globals = { "vim" },
							},
							workspace = {
								-- Make the server aware of Neovim runtime files and plugins
								library = { vim.env.VIMRUNTIME },
								checkThirdParty = false,
							},
							telemetry = {
								enable = false,
							},
						},
					},
				},
				pyright = {},
				nixd = {
					nixpkgs = {
						expr = "import <nixpkgs> { }",
					},
					formatting = {
						command = { "nixfmt" },
					}
				},
				rust_analyzer = {},
				clangd = {},
				ltex = {},
				r_language_server = {},
			}
		},
		config = function(_, opts)
			local lspconfig = require('lspconfig')
			for server, config in pairs(opts.servers) do
				-- passing config.capabilities to blink.cmp merges with the capabilities in your
				-- `opts[server].capabilities, if you've defined it
				config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
				lspconfig[server].setup(config)
			end
		end
	},
	{
		'saghen/blink.cmp',
		-- optional: provides snippets for the snippet source
		dependencies = { 'L3MON4D3/LuaSnip' },

		version = 'v0.*', -- use a release tag to download pre-built binaries
		opts = {
			-- 'default' for mappings similar to built-in completion
			-- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
			-- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
			-- see the "default configuration" section below for full documentation on how to define
			-- your own keymap.
			snippets = {
				expand = function(snippet) require('luasnip').lsp_expand(snippet) end,
				active = function(filter)
					if filter and filter.direction then
						return require('luasnip').jumpable(filter.direction)
					end
					return require('luasnip').in_snippet()
				end,
				jump = function(direction) require('luasnip').jump(direction) end,
			},
			keymap = {
				preset = 'enter',
				cmdline = {
					preset = 'super-tab'
				}
			},

			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = 'mono'
			},

			-- default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, via `opts_extend`
			sources = {
				default = {
					'luasnip', 'lsp', 'path', 'buffer'
				},
				providers = {
					luasnip = {
						score_offset = 2,
					},
					lsp = {
						score_offset = 1
					},
					buffer = {
						score_offset = 1
					}
				}
			},

			-- signature = { enabled = true }
		},
		opts_extend = { "sources.default" }
	},
	{
		"L3MON4D3/LuaSnip",
		build = "make install_jsregexp"
	},
	{
		'nvim-treesitter/nvim-treesitter',
		lazy = true,
		build = ':TSUpdate',
		event = { 'BufReadPre', 'BufNewFile' },
		main = 'nvim-treesitter.configs',
		opts = { highlight = { enable = true }, }
	},
	-- 'saadparwaiz1/cmp_luasnip',
	'williamboman/mason.nvim',
	'williamboman/mason-lspconfig.nvim',
	{
		"folke/trouble.nvim",
		lazy = true,
		opts = {},
	},
	-- Testing
	-- R
	{
		"R-nvim/R.nvim",
		lazy = false,
		ft = { 'r', 'rmd', }
	},
	-- File navigation tools
	{
		'goolord/alpha-nvim',
		config = function()
			require 'alpha-config'
			require 'alpha'.setup(require 'alpha.themes.dashboard'.config)
		end
	},
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.5',
		dependencies = { 'nvim-lua/plenary.nvim', 'MunifTanjim/nui.nvim' }
	},
	-- Editing tools
	-- "tpope/vim-surround",
	{
		'ggandor/leap.nvim',
		config = function()
			require('leap').create_default_mappings()
		end
	},
	'Konfekt/vim-alias',
	'tpope/vim-fugitive',
	'tpope/vim-eunuch',
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		enabled = not vim.g.started_by_firenvim,
		opts = {
			cmdline = {
				view = "cmdline",
			},
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			-- "rcarriga/nvim-notify",
		}
	},
	-- Aesthetics
	'nvim-lualine/lualine.nvim',
	'nvim-tree/nvim-web-devicons',
	-- 'lukas-reineke/indent-blankline.nvim',
	-- {
	-- 	'akinsho/bufferline.nvim',
	-- 	lazy = true,
	-- 	version = "*",
	-- 	dependencies = 'nvim-tree/nvim-web-devicons',
	-- 	--		enabled = not vim.g.started_by_firenvim,
	-- },
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
	{
		"epwalsh/obsidian.nvim",
		version = "*", -- recommended, use latest release instead of latest commit
		lazy = true,
		ft = "markdown",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim"
		}
	},
	{
		"jbyuki/nabla.nvim",
		ft = "markdown",
	},
	{
		"3rd/image.nvim",
		ft = "markdown",
	},
	{
		"3rd/diagram.nvim",
		ft = "markdown",
		opts = { -- you can just pass {}, defaults below
			renderer_options = {
				mermaid = {
					background = "transparent", -- nil | "transparent" | "white" | "#hex"
					theme = "dark", -- nil | "default" | "dark" | "forest" | "neutral"
					scale = 1, -- nil | 1 (default) | 2  | 3 | ...
				},
			}
		},

	},
	{
		'MeanderingProgrammer/render-markdown.nvim',
		opts = {},
		dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
		ft = "markdown",
	},
	{
		"pocco81/true-zen.nvim",
		lazy = true
	},
	{
		"maxdulay/luasnip-latex-snippets.nvim",
		dependencies = { "L3MON4D3/LuaSnip", 'nvim-treesitter/nvim-treesitter' },
		ft = { "markdown", "rmarkdown" },
		config = function()
			require('luasnip-latex-snippets').setup({
				use_treesitter = true,
				allow_on_markdown = true,
			})
			require('luasnip-latex-config')
			require('luasnip').config.setup { enable_autosnippets = true }
		end,
	},
	{
		"epwalsh/pomo.nvim",
		version = "*", -- Recommended, use latest release instead of latest commit
		lazy = true,
		cmd = { "TimerStart", "TimerRepeat", "TimerSession" },
		dependencies = {
			-- "rcarriga/nvim-notify",
		},
	},
	{
		"vifm/vifm.vim",
	},
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			bigfile = { enabled = true },
			notifier = { enabled = true },
			quickfile = { enabled = true },
			terminal = {
				enabled = true,
				win = { style = "terminal" },
			},
			indent = { enabled = true },
		},
	},
})
-- Configs and setups
vim.g.firenvim_config = {
	globalSettings = { alt = "all" },
	localSettings = {
		[".*"] = {
			cmdline  = "firenvim",
			content  = "text",
			priority = 0,
			selector = "textarea",
			takeover = "never"
		}
	}
}
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_snipmate").lazy_load()
require("pomo-config")
require("obsidian-config")
require("luasnip-config")
require("lsp-config")
require('keybindings')
require('tree-sitter')
require('lualine').setup()
require('tokyonight').setup {
	style = "night",
	--transparent = vim.g.neovide == nil}
	-- transparent = true,
	on_colors = function(colors)
		colors.bg = "#000000"
		colors.bg_float = "#000000"
	end
}

-- require("bufferline-config")
-- default config
-- vim settings
vim.cmd('colorscheme tokyonight')
vim.api.nvim_set_hl(0, "SnacksNormal", { link = "Normal" })
vim.opt.number = true
vim.opt.relativenumber = true
vim.cmd("syntax on")
vim.opt.mouse = "a"
vim.cmd("set path+=**")
vim.cmd("set noswapfile")
vim.opt.wildmenu = true
vim.opt.incsearch = true
vim.opt.smartindent = true
vim.opt.ic = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.clipboard = "unnamed" -- vim.cmd("set clipboard=unnamedplus")
vim.opt.clipboard = "unnamedplus"
vim.opt.linebreak = true
vim.opt.termguicolors = true
require('telescope-config')
