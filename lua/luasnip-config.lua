local ls = require('luasnip')
vim.keymap.set({ "i" }, "<CR>", function()
		if ls.expand_or_jumpable() then
			ls.expand()
		else
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, false, true), "n", false)
		end
	end,
	{ silent = true }
)
vim.keymap.set({ "i", "s" }, "<Tab>", function()
		if ls.expand_or_jumpable() then
			ls.jump(1)
		else
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
		end
	end,
	{ silent = true }
)
vim.keymap.set({ "i", "s" }, "<S-Tab>", function() ls.jump(-1) end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-E>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, { silent = true })

-- some shorthands...
local snip = ls.snippet
local func = ls.function_node

local date = function() return { os.date('%Y-%m-%d') } end

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
local s = ls.snippet
local sn = ls.snippet_node
-- local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
-- local f = ls.function_node
-- local c = ls.choice_node
local d = ls.dynamic_node
-- local r = ls.restore_node
-- local events = require("luasnip.util.events")
-- local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
-- local l = extras.lambda
-- local rep = extras.rep
-- local p = extras.partial
-- local m = extras.match
-- local n = extras.nonempty
-- local dl = extras.dynamic_lambda
-- local fmt = require("luasnip.extras.fmt").fmt
-- local fmta = require("luasnip.extras.fmt").fmta
-- local conds = require("luasnip.extras.expand_conditions")
-- local postfix = require("luasnip.extras.postfix").postfix
-- local types = require("luasnip.util.types")
-- local parse = require("luasnip.util.parser").parse_snippet
-- local ms = ls.multi_snippet
-- local k = require("luasnip.nodes.key_indexer").new_key
ls.add_snippets(nil, {
	cpp = {
		s("header", {
			t({ "/*******************************************************************************",
				"* Filename: " }), d(1, function(args)
			local buf = vim.api.nvim_get_current_buf()
			local path = vim.api.nvim_buf_get_name(buf)
			local filename = path:gsub(".*/", "")
			return sn(nil, t { filename })
		end),
			t({ "",
				"* Author  : Maxwell Dulay",
				"* Version : " }), i(2),
			t({ "",
				"* Date    : " }), extras.partial(os.date, "%B %d, %Y"),
			t({ "",
				"* Description: " }), i(3),
			t({ "",
				"* Pledge  : I pledge my honor that I have abided by the Stevens Honor System.",
				"******************************************************************************/" })
		})

	},
}
)
