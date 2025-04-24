-- Example for configuring Neovim to load user-installed installed Lua rocks:
--
-- vim.g.vifm_replace_netrw = true
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
	'vuciv/golf',
	{
		'glacambre/firenvim',
		-- Lazy load firenvim
		-- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
		--
		enabled = vim.g.started_by_firenvim,
		lazy = not vim.g.started_by_firenvim,
		build = function()
			vim.fn["firenvim#install"](0)
		end,
		init = function()
			vim.g.firenvim_config = {
				globalSettings = { alt = "all" },
				localSettings = {
					[".*"] = {
						cmdline  = "firenvim",
						content  = "text",
						priority = 0,
						selector = "textarea",
						takeover = "never",
						filename =
						'/tmp/{hostname%32}_{pathname%32}_{selector%32}_{timestamp%32}.md'
					}
				}
			}
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
		-- event = {"BufReadPost", "BufNewFile"},
		cmd = { "LspInfo", "LspInstall", "LspUninstall", "LspStart" },
		lazy = true,

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
				-- ltex = {
				-- 	language = "en-US",
				-- 	dictionary = function()
				-- 		local path = vim.fn.expand("~/.config/nvim/spell/en.utf-8.add")
				-- 		return {en_US = ':' .. path}
				-- 	end
				-- },
				vale_ls = {},
				r_language_server = {},
				ocamllsp = {},
				-- harper_ls = {},

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
		dependencies = {
			-- { 'L3MON4D3/LuaSnip',    version = 'v2.*', lazy = true },
			{ 'saghen/blink.compat', lazy = true, ft = "markdown" },
			{
				'Kaiser-Yang/blink-cmp-dictionary',
				dependencies = { 'nvim-lua/plenary.nvim' },
				ft = "markdown"
			},
		},
		lazy = true,

		version = '*', -- use a release tag to download pre-built binaries
		opts = {
			-- 'default' for mappings similar to built-in completion
			-- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
			-- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
			-- see the "default configuration" section below for full documentation on how to define
			-- your own keymap.
			-- snippets = { preset = 'luasnip' },
			keymap = {
				preset = 'super-tab',
			},

			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = 'mono'
			},

			-- default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, via `opts_extend`
			sources = {
				default = function(ctx)
					if vim.bo.filetype ~= 'markdown' then
						return { 'lsp', 'path', 'buffer' }
						-- elseif success and node and in_math(node) and vim.treesitter.get_parser(0, "latex") then
						-- 	return { 'snippets', 'obsidian', 'obsidian_tags', 'obsidian_new',
						-- 		'lsp', 'path', 'buffer' }
					else
						return { 'lsp', 'snippets', 'dictionary', 'path', 'buffer', 'markdown' }
					end
				end,
				-- default = {
				-- 	'snippets', 'obsidian', 'obsidian_new', 'obsidian_tags', 'lsp', 'path', 'buffer'
				-- },
				providers = {
					dictionary = {
						module = 'blink-cmp-dictionary',
						name = 'Dict',
						-- Make sure this is at least 2.
						-- 3 is recommended
						min_keyword_length = 3,
						max_items = 8,
						opts = {
							dictionary_files = { vim.fn.expand('~/.config/nvim/spell/en.utf-8.add'), vim.fn.expand('~/words.txt') }
						},
					},
					-- obsidian = {
					-- 	name = "obsidian",
					-- 	score_offset = 1
					-- },
					-- obsidian_new = {
					-- 	module = "blink.compat.source",
					-- },
					-- obsidian_tags = {
					-- 	name = "obsidian_tags",
					-- 	score_offset = 1
					-- },
					snippets = {
						score_offset = 2,
					},
					lsp = {
						score_offset = 1
					},
					buffer = {
						score_offset = 1
					},
					markdown = {
						name = 'RenderMarkdown',
						module = 'render-markdown.integ.blink',
						fallbacks = { 'lsp' },
					}
				}
			},
			completion = {
				menu = {
					draw = {
						treesitter = { 'lsp' },
					}
				}
			}

			-- signature = { enabled = true }
		},
		opts_extend = { "sources.default" }
	},
	{
		"L3MON4D3/LuaSnip",
		build = "make install_jsregexp",
		lazy = true,
		config = function()
			require("luasnip-config")
		end
	},
	{
		'nvim-treesitter/nvim-treesitter',
		lazy = true,
		build = ':TSUpdate',
		event = { 'BufReadPre', 'BufNewFile' },
		main = 'nvim-treesitter.configs',
		-- init = function()
		-- 	vim.treesitter.language.register('scheme', 'racket') -- the someft filetype will use the python parser and queries.
		-- 	vim.filetype.add({
		-- 		pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
		-- 	})
		-- end,
		opts = require("tree-sitter")
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
		'nvim-telescope/telescope.nvim',
		tag = '0.1.5',
		dependencies = { 'nvim-lua/plenary.nvim', 'MunifTanjim/nui.nvim' },
		lazy = true,
		cmd = { "Telescope" },
		opts = {
			defaults = {
				border = {},
				borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
			}
		}
	},
	-- Editing tools
	-- "tpope/vim-surround",
	'Konfekt/vim-alias',
	-- 'tpope/vim-fugitive',
	{
		'tpope/vim-eunuch',
		lazy = true,
		cmd = { "Remove", "Delete", "Move", "Chmod", "Mkdir", "SudoWrite", "SudoEdit" },

	},
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
	{
		'nvim-lualine/lualine.nvim',
		event = "VeryLazy",
		opts = {},
	},
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
		opts = {
			style = "night",
			--transparent = vim.g.neovide == nil
			-- transparent = true,
			on_colors = function(colors)
				colors.bg = "#000000"
				colors.bg_float = "#000000"
			end
		},
	},
	{
		"obsidian-nvim/obsidian.nvim",
		version = "*", -- recommended, use latest release instead of latest commit
		lazy = true,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim"
		},
		opts = require("obsidian-config"),
		cmd = { "ObsidianQuickSwitch", "ObsidianOpen", "ObsidianNew", "ObsidianToday", "ObsidianSearch" }
	},
	-- {
	-- 	"3rd/image.nvim",
	-- 	ft = "markdown",
	-- },
	-- {
	-- 	"3rd/diagram.nvim",
	-- 	ft = "markdown",
	-- 	opts = { -- you can just pass {}, defaults below
	-- 		renderer_options = {
	-- 			mermaid = {
	-- 				background = "transparent", -- nil | "transparent" | "white" | "#hex"
	-- 				theme = "dark", -- nil | "default" | "dark" | "forest" | "neutral"
	-- 				scale = 1, -- nil | 1 (default) | 2  | 3 | ...
	-- 			},
	-- 		}
	-- 	},
	--
	-- },
	{
		'MeanderingProgrammer/render-markdown.nvim',
		opts = {
			bullet = {
				-- Turn on / off list bullet rendering
				enabled = true,
				icons = { '●', '○', '◆', '◇' },
				-- Padding to add to the left of bullet point
				left_pad = 0,
				-- Padding to add to the right of bullet point
				right_pad = 0,
				-- Highlight for the bullet icon
				highlight = 'RenderMarkdownBullet',
			},
			checkbox = {
				-- Turn on / off checkbox state rendering
				enabled = true,
			},
			link = {
				enabled = true,
			},
			heading = { enabled = true },
			latex = { enabled = false },
		},
		dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
		ft = "markdown",
	},
	{
		"pocco81/true-zen.nvim",
		lazy = true
	},
	{
		"maxdulay/luasnip-latex-snippets.nvim",
		enabled = true,
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
		"vifm/vifm.vim",
		init = function()
			vim.g.vifm_replace_netrw = true
		end,
	},
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			bigfile = { enabled = true },
			notifier = { enabled = true, style = "minimal" },
			quickfile = { enabled = true },
			image = { enabled = true, img_dirs = { "../" }, doc = { inline = false } },
			terminal = {
				enabled = true,
				win = { style = "terminal" },
			},
			dashboard = require("snacks-dashboard-config"),
			indent = { enabled = true, animate = { enabled = false } },
			styles = {
				snacks_image = {
					border = "none"
				},
				notification_history = {
					border = "none",
					wo = { winhighlight = "Normal:pmenu" },
					keys = { q = "close" },
				}
			}
		},
	},
	-- optional lualine component to show captured events
	-- when the profiler is running

}, {
	-- defaults = { lazy = true },
	performance = {
		cache = {
			enabled = true,
		},
		rtp = {
			disabled_plugins = {
				"netrwPlugin",
				"gzip",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			}
		}
	},
	profiling = {
		require = true,
	}
})
-- Configs and setups
-- require("luasnip.loaders.from_vscode").lazy_load()
-- require("luasnip.loaders.from_snipmate").lazy_load()
require("lsp-config")
require('keybindings')
-- require('tree-sitter')

-- default config
-- vim settings
--
vim.cmd('colorscheme tokyonight-night')
require("highlights")
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
-- vim.opt.clipboard = "unnamed" -- vim.cmd("set clipboard=unnamedplus")
vim.opt.clipboard = "unnamedplus"
vim.opt.linebreak = true
vim.opt.termguicolors = true
vim.opt.autochdir = true
vim.opt.grepprg = "rg --vimgrep"
-- vim.opt.spell = true
-- vim.opt.spelllang="en_us"
-- Please arrange the patterns for your favorite plugins by yourself.

vim.api.nvim_create_autocmd("UIEnter", {
	pattern = "*",
	command = "LspStart"
})
-- vim.api.nvim_create_autocmd("BufNewFile", {
-- 	pattern = "*",
-- 	command = "LspStart"
-- })
