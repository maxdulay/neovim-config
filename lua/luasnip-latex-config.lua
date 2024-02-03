local ls = require("luasnip")
local conds = require("luasnip.extras.expand_conditions")
 
local utils = require("luasnip-latex-snippets.util.utils")

local not_math = utils.not_math(true) -- pass true if using Treesitter
local is_math = utils.is_math(true)

local snip = ls.parser.parse_snippet({ trig = "km", name = "Math" }, "$${1:${TM_SELECTED_TEXT}}$$0")

snip.condition = not_math
snip.priority = 10 -- anything greater than 0.

ls.add_snippets("markdown", { snip }, {
    type = "autosnippets",
})

local snip = ls.parser.parse_snippet({ trig = "sub", name = "Subscript" }, "_{$1}$0")

snip.condition = is_math 
snip.priority = 10 -- anything greater than 0.

ls.add_snippets("markdown", { snip }, {
    type = "autosnippets",
})
local snip = ls.parser.parse_snippet({ trig = "land", name = "Logical and" }, "\\land")
snip.condition = is_math 
snip.priority = 10 -- anything greater than 0.
ls.add_snippets("markdown", { snip }, {type = "autosnippets",})
local snip = ls.parser.parse_snippet({ trig = "lor", name = "Logical or" }, "\\lor")
snip.condition = is_math 
snip.priority = 10 -- anything greater than 0.
ls.add_snippets("markdown", { snip }, {type = "autosnippets",})
local snip = ls.parser.parse_snippet({ trig = "equiv", name = "Equivalent" }, "\\equiv")
snip.condition = is_math 
snip.priority = 10 -- anything greater than 0.
ls.add_snippets("markdown", { snip }, {type = "autosnippets",})
local snip = ls.parser.parse_snippet({ trig = "in", name = "Belongs to" }, "\\in")
snip.condition = is_math 
snip.priority = 10 -- anything greater than 0.
ls.add_snippets("markdown", { snip }, {type = "autosnippets",})
local snip = ls.parser.parse_snippet({ trig = "frall", name = "For all" }, "\\forall")
snip.condition = is_math 
snip.priority = 10 -- anything greater than 0.
ls.add_snippets("markdown", { snip }, {type = "autosnippets",})
local snip = ls.parser.parse_snippet({ trig = "exists", name = "There exists" }, "\\exists")
snip.condition = is_math 
snip.priority = 10 -- anything greater than 0.
ls.add_snippets("markdown", { snip }, {type = "autosnippets",})
