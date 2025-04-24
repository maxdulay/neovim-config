-- vim.api.nvim_create_autocmd("BufWritePost", {
-- 	pattern = "*.ml",
-- 	callback = function()
-- 		vim.system({ 'dune', 'rpc', 'build', '.' }, { text = true }, function(obj)
-- 			print(obj.code)
-- 			print(obj.stdout)
-- 			print(obj.stderr)
-- 		end)
-- 	end
-- })
vim.system({ 'dune', 'build', '--watch'}, { text = true }, function(obj)
	print(obj.code)
	print(obj.stdout)
	print(obj.stderr)
end)
-- vim.system({ 'dune', 'build', '@@default', "@runtest"}, { text = true }, function(obj)
-- 	print(obj.code)
-- 	print(obj.stdout)
-- 	print(obj.stderr)
-- end)
-- dune build @@default @runtest --watch
vim.opt.tabstop=2
vim.opt.shiftwidth=2
--
-- vim.keymap.set("n", "<F5>", ":lua Snacks.terminal.toggle()<CR>dune run<CR>")
-- -- vim.cmd("autocmd FileType ocaml nnoremap <F5> :lua Snacks.terminal.toggle()<CR>dune run<CR>")
-- vim.keymap.set("n", "<F6>", ":lua Snacks.terminal.toggle(\"dune build;read '?Press enter to continue...'\", {win = {position = \"bottom\"}})<CR>")
-- -- vim.cmd("autocmd FileType ocaml nnoremap <F6> :lua Snacks.terminal.toggle(\"dune build;read '?Press enter to continue...'\", {win = {position = \"bottom\"}})<CR>")
-- vim.keymap.set("n", "<F7>", ":lua Snacks.terminal.toggle(\"utop\", {win = {position = \"bottom\"}})<CR>#use \"" .. vim.fn.expand("%") .."\";;<CR>")
-- -- vim.cmd("autocmd FileType ocaml nnoremap <F7> :lua Snacks.terminal.toggle(\"utop\", {win = {position = \"bottom\"}})<CR>#use \"" .. vim.fn.expand("%") .."\";;<CR>")
-- vim.keymap.set("t", "<F7>", "<C-\\><C-n>:lua Snacks.terminal.toggle('utop')<CR>")
