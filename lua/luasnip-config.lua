ls = require('luasnip')
vim.keymap.set({"i"}, "<CR>", function()
	if ls.expand_or_jumpable() then
		ls.expand()
	else 
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, false, true), "n", false)	
	end
end,
{silent = true}
)
vim.keymap.set({"i"}, "<Tab>", function()
	if ls.expand_or_jumpable() then
		ls.jump( 1)
	else 
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)	
	end
end,
{silent = true}
)
vim.keymap.set({"i", "s"}, "<S-Tab>", function() ls.jump(-1) end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-E>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, {silent = true})

-- some shorthands...
local snip = ls.snippet
local node = ls.snippet_node
local text = ls.text_node
local insert = ls.insert_node
local func = ls.function_node
local choice = ls.choice_node
local dynamicn = ls.dynamic_node

local date = function() return {os.date('%Y-%m-%d')} end

ls.add_snippets(nil, {
    all = {
        snip({
            trig = "date",
            namr = "Date",
            dscr = "Date in the form of YYYY-MM-DD",
        }, {
            func(date, {}),
        }),
    },
})
