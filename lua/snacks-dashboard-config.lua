return {
	enabled = not vim.g.started_by_firenvim,
	row = 10,
	preset = {
		pick = nil,
		keys = {
			{ icon = "󰀠 >", key = "d", desc = " Daily", action = ":ObsidianToday " },
			{ icon = " >", key = "e", desc = " New file", action = ":ene | startinsert" },
			{ icon = "󰎜 >", key = "n", desc = " New note", action = ":ObsidianNew" },
			{ icon = "󰠮 >", key = "o", desc = " Obsidian vault", action = ":ObsidianQuickSwitch" },
			{ icon = " >", key = "f", desc = " Find file", action = ":cd $HOME | Telescope find_files" },
			{ icon = " >", key = "r", desc = " Recent", action = ":Telescope oldfiles" },
			{ icon = " >", key = "s", desc = " Settings", action = ":e $MYVIMRC | :cd %:p:h  | :Vifm " },
			{ icon = " >", key = "q", desc = " Quit NVIM", action = ":qa" },
		},
		header = [[
                                                                     
       ████ ██████           █████      ██                     
      ███████████             █████                             
      █████████ ███████████████████ ███   ███████████   
     █████████  ███    █████████████ █████ ██████████████   
    █████████ ██████████ █████████ █████ █████ ████ █████   
  ███████████ ███    ███ █████████ █████ █████ ████ █████  
 ██████  █████████████████████ ████ █████ █████ ████ ██████ 
                                                                       
                           Im cheesed to meet you                      ]]
	},
}
