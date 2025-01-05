vim.api.nvim_set_hl(0, "TelescopeNormal", { link = "Pmenu" })
vim.api.nvim_set_hl(0, "TelescopeBorder", { link = "Pmenu" })
vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { link = "@diff.plus" })
vim.api.nvim_set_hl(0, "TelescopeTitle", { link = "@diff.plus" })
vim.api.nvim_set_hl(0, "TelescopePromptTitle", { link = "@diff.minus" })
vim.api.nvim_set_hl(0, "TelescopePromptBorder", { link = "Pmenu" })
vim.api.nvim_set_hl(0, "NormalFloat", { link = "Pmenu" })
require("telescope").setup({
	defaults = {
		border = {},
		borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
	}
})
