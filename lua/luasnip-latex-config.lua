local ls = require("luasnip")
local conds = require("luasnip.extras.expand_conditions")
 
local utils = require("luasnip-latex-snippets.util.utils")

local not_math = utils.not_math(true) -- pass true if using Treesitter

local snip = ls.parser.parse_snippet({ trig = "km", name = "Math" }, "$${1:${TM_SELECTED_TEXT}}$$0")

snip.condition = not_math
snip.priority = 10 -- anything greater than 0.

ls.add_snippets("markdown", { snip }, {
    type = "autosnippets",
})

