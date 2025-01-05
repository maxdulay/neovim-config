vim.g.mapleader = " "
vim.g.maplocalleader = " "
--- vim.cmd("nnoremap <Tab> <C-w>w")
vim.cmd("Alias trouble Telescope<Space>diagnostics")
vim.keymap.set("i", "kj", "<Esc>")
vim.cmd("inoremap kj <Esc>")
vim.keymap.set("v", "ib", "iB")
vim.keymap.set("v", "iB", "ib")
vim.keymap.set("v", "aB", "ab")
vim.keymap.set("v", "aB", "ab")
vim.keymap.set("n", ";", ":")
vim.keymap.set("v", ";", ":")
vim.cmd("Alias format lua<Space>vim.lsp.buf.format()")
vim.cmd("Alias f tab<Space>split")
vim.cmd("Alias focus tab<Space>split")
vim.keymap.set("t", "<C-k><C-j>", "<C-\\><C-n>")
vim.keymap.set("n", "<C-u>", "<C-u>zz<CR>")
vim.keymap.set("n", "<C-d>", "<C-d>zz<CR>")
vim.keymap.set("n", "<C-t>", ":Vifm<CR>")
vim.cmd("Alias vifm Vifm")
vim.cmd("Alias vs vs|Vifm")
vim.cmd("Alias ff Telescope<Space>find_files")
vim.cmd("Alias qq bd!")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.cmd("Alias bl BufferLinePick")
vim.cmd("Alias bld BufferLinePickClose")
vim.cmd("Alias bdd BufferLineCloseOthers")
vim.keymap.set("n", "<F4>", ":lua Snacks.terminal.toggle()<CR>")
vim.keymap.set("t", "F4", "<C-\\><C-n>:lua Snacks.terminal.toggle()<CR>")
-- markdown
-- vim.cmd("autocmd FileType markdown vmap <F5> :!column -t -s '|' -o '|'")
vim.cmd("autocmd Filetype markdown nnoremap <C-p> :lua require('nabla').popup()<CR>")
vim.cmd("autocmd FileType markdown nnoremap <F5> :lua require'nabla'.enable_virt({autogen = true, silent = true,})<CR>")
vim.cmd("autocmd FileType markdown nnoremap <F6> :!pandoc --wrap=preserve % -o ~/Documents/%:t:r.pdf<CR>")
-- rmarkdown
vim.cmd("autocmd FileType rmd nnoremap <F7> :RSend rmarkdown::render('./%')<CR>")
-- Python
vim.cmd("autocmd FileType python nnoremap <F5> :w<CR>:split<CR>:res -20<CR>:terminal ~/python/bin/python %<CR>")
vim.cmd("autocmd FileType python inoremap <F5> <esc>:w<CR>:split<CR>:res -20<CR>:terminal ~/python/bin/python %<CR>")
vim.cmd(
	"autocmd FileType python nnoremap <F6> :w<CR>:bd! term<CR>:split<CR>:res -20<CR>:terminal ~/python/bin/python %<CR>")
vim.cmd(
	"autocmd FileType python inoremap <F6> <esc>:w<CR>:bd! term<CR>:split<CR>:res -20<CR>:terminal ~/python/bin/python %<CR>")
-- Julia
vim.cmd("autocmd FileType julia nnoremap <F5> :w<CR>:split<CR>:res -20<CR>:terminal julia %<CR>")
-- Rust
vim.cmd("autocmd FileType rust nnoremap <F5> :w<CR>:split<CR>:res -20<CR>:terminal cargo run %<CR>")
-- Java
vim.cmd("autocmd FileType java nnoremap <F5> :w<CR>:cd %:p:h<CR>:cd ../<CR>:split<CR>:res -20<CR>:terminal java %<CR>")
-- CPP
vim.cmd(
	"autocmd FileType cpp nnoremap <F5> :w<CR>:!cd %:p:h<CR>:split<CR>:res -20<CR>:terminal multipass exec -d /home/ubuntu/%:p:gs?/home/maxdu?Home?:h primary make; multipass exec -d /home/ubuntu/%:p:gs?/home/maxdu?Home?:h primary ./%:t:r ")
vim.cmd(
	"autocmd FileType cpp nnoremap <F7> :w<CR>:!cd %:p:h<CR>:split<CR>:res -20<CR>:terminal multipass exec -d /home/ubuntu/%:p:gs?/home/maxdu?Home?:h primary make; multipass exec -d /home/ubuntu/%:p:gs?/home/maxdu?Home?:h primary ")
-- Racket/scheme
-- 	Use F6 to run in REPL
vim.cmd("autocmd FileType eopl set filetype=scheme")
vim.cmd("autocmd FileType racket set filetype=scheme")
vim.cmd("autocmd FileType scheme inoremap <F5><esc>:w<CR>:split<CR>:res -20<CR>:terminal racket %<CR>")
vim.cmd("autocmd FileType scheme inoremap <F5> <esc>:w<CR>:split<CR>:res -20<CR>:terminal racket %<CR>")
vim.cmd(
	"autocmd FileType scheme inoremap <F6> <esc>:w<CR>:split<CR>:res -20<CR>:terminal racket -i -f <(tail -n +2 %)<CR>")
vim.cmd("autocmd FileType scheme nnoremap <F6> :w<CR>:split<CR>:res -20<CR>:terminal racket -i -f <(tail -n +2 %)<CR>")
-- nix

-- Function to switch windows, skipping specific buffer types or file types

function SwitchToNextWindow()
	-- Get the current window
	local current_win = vim.api.nvim_get_current_win()
	-- Get a list of all open windows
	local all_windows = vim.api.nvim_list_wins()
	-- Find the index of the current window
	local current_index = nil
	for i, win in ipairs(all_windows) do
		if win == current_win then
			current_index = i
			break
		end
	end

	-- Switch to next window if it does not have a zindex attribute (that means it is floating). Otherwise, try the next window
	if current_index then
		for i = 0, #all_windows, 1 do
			-- Wrap around to the first window if we're at the end of the list
			local next_index = ((current_index + i) % #all_windows) + 1
			current_win = all_windows[next_index]
			if current_win and not vim.api.nvim_win_get_config(current_win).zindex then
				vim.api.nvim_set_current_win(all_windows[next_index])
				break
			end
		end
	end
end

vim.keymap.set("n", "<Tab>", ":lua SwitchToNextWindow()<CR>", { silent = true })
