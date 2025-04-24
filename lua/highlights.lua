math.randomseed(os.time())
local function pick_color()
	local colors = { "String", "Identifier", "Keyword", "Number" }
	return colors[math.random(#colors)]
end
vim.api.nvim_set_hl(0, "SnacksDashboardHeader", { link = pick_color() })

vim.api.nvim_set_hl(0, "TelescopeNormal", { link = "Pmenu" })
vim.api.nvim_set_hl(0, "TelescopeBorder", { link = "Pmenu" })
vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { link = "@diff.plus" })
vim.api.nvim_set_hl(0, "TelescopeTitle", { link = "@diff.plus" })
vim.api.nvim_set_hl(0, "TelescopePromptTitle", { link = "@diff.minus" })
vim.api.nvim_set_hl(0, "TelescopePromptBorder", { link = "Pmenu" })
vim.api.nvim_set_hl(0, "NormalFloat", { link = "Pmenu" })

vim.api.nvim_set_hl(0, "BlinkCmpMenu", { link = "Pmenu" })
vim.api.nvim_set_hl(0, "SnacksNormal", { link = "Normal" })
