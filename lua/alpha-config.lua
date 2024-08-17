local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")
math.randomseed(os.time())
local function pick_color()
	local colors = {"String", "Identifier", "Keyword", "Number"}
	return colors[math.random(#colors)]
end
-- Set header
dashboard.section.header.val = {
    [[                                                                       ]],
    [[                                                                     ]], [[       ████ ██████           █████      ██                     ]],
    [[      ███████████             █████                             ]],
    [[      █████████ ███████████████████ ███   ███████████   ]],
    [[     █████████  ███    █████████████ █████ ██████████████   ]],
    [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
    [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
    [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
    [[                                                                       ]],
    [[                           Im cheesed to meet you                      ]] 
}
dashboard.section.header.opts.hl = pick_color()

-- Set menu
dashboard.section.buttons.val = {
    dashboard.button( "d", "󰀠  > Daily"	   ,  ":ObsidianToday <CR>"),
    dashboard.button( "e", "  > New file" , ":ene <BAR> startinsert <CR>"),
    dashboard.button( "n", "󰎜  > New note" , ":ObsidianNew<CR>"),
    dashboard.button( "o", "󰠮  > Obsidian vault", ":ObsidianQuickSwitch<CR>"),
    dashboard.button( "f", "  > Find file", ":cd $HOME | Telescope find_files<CR>"),
    dashboard.button( "r", "  > Recent"   , ":Telescope oldfiles<CR>"),
    dashboard.button( "s", "  > Settings" , ":e $MYVIMRC | :cd %:p:h <CR> | :NERDTree <CR>"),
    dashboard.button( "q", "  > Quit NVIM", ":qa<CR>"),
}

alpha.setup(dashboard.opts)

-- Disable folding on alpha buffer
vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])
