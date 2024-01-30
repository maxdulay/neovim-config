local cmp = require("cmp")

for _, source in pairs(cmp.get_config().sources) do
	print(source.name)
end
