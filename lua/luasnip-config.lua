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
vim.keymap.set({"i", "s"}, "<Tab>", function()
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
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key
ls.add_snippets(nil, {
	java = {
	s("fsetter", {
		t"public void set", i(1), t{"("}, i(2),t{" "}, d(3, function(args)
				return sn(nil, {
					t{(args[1][1]:gsub("^%u", string.lower))}
				})
			end,
		{1}),t{") {"}, t{"", "\tthis."},
		d(4, function(args)
				return sn(nil, {
					t{(args[1][1]:gsub("^%u", string.lower))}
				})
			end,
		{1}), t{" = "},
		d(5, function(args)
				return sn(nil, {
					t{(args[1][1]:gsub("^%u", string.lower))}
				})
			end,
		{1}),t{";", "}"}
	}),
	s("fgetter", {
		t"public ", i(1, "RETURNTYPE"), t{" get"}, i(2),t{"() {", "\treturn "}, d(3, function(args)
				return sn(nil, {t{(args[1][1]:gsub("^%u", string.lower))}})
			end,
		{2}),t{";", "}"}
	}),
	s("setter", {
		t"public void set", i(1), t{"("}, i(2), t{" "}, i(3), t{") {", "\t"},i(4),t{" = "},
		d(5, function(args)
				return sn(nil, {i(1, args[1])})
			end,
		{3}),t{"", "}"}
	}),
	s("getter", {
		t"public ", i(1, "RETURNTYPE"), t{" get"}, i(2), t{"() {", "\t return "}, i(3), t{";", "}"},
		}),
	s("method", {
		t("public "), i(1), t(" "), i(2), t("("), i(3),t{") {","\t"}, i(4), t{"", "}"},
		}),
	s("main", {
		t("public static void main(String[] args) {", ""), i(1), t{"", "}"},
		}),
	s("print", {
		t("System.out.println("), i(1), t{");", ""},
		})
	
},
	scheme = {
		s(
		{
			trig="p",
			dscr="parenthesees",
			regTrig=false,
			priority=100,
		},
			{t{"("}, i(1), t{")"}}
		)
	}
})
