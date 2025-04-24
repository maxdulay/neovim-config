vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.cmd("Alias trouble Telescope<Space>diagnostics")
vim.keymap.set("i", "kj", "<Esc>")
vim.keymap.set("v", "ib", "iB")
vim.keymap.set("v", "iB", "ib")
vim.keymap.set("v", "ab", "aB")
vim.keymap.set("v", "aB", "ab")
vim.cmd("Alias format lua<Space>vim.lsp.buf.format()")
vim.cmd("Alias f tab<Space>split")
vim.cmd("Alias focus tab<Space>split")
vim.keymap.set("t", "<C-k><C-j>", "<C-\\><C-n>")
vim.keymap.set("n", "<C-u>", "<C-u>zz<CR>")
vim.keymap.set("n", "<C-d>", "<C-d>zz<CR>")
vim.keymap.set("n", "<C-t>", "<cmd>Vifm<CR>")
vim.cmd("Alias vifm Vifm")
vim.cmd("Alias vs vnew|Vifm")
vim.cmd("Alias ff Telescope<Space>find_files")
vim.cmd("Alias G lua<Space>Snacks.lazygit.open()")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-p>", "<CMD>cprev<CR>zz")
vim.keymap.set("n", "<C-n>", "<CMD>cnext<CR>zz")
-- vim.cmd("Alias bl BufferLinePick")
-- vim.cmd("Alias bld BufferLinePickClose")
-- vim.cmd("Alias bdd BufferLineCloseOthers")
vim.keymap.set("n", "<F4>", "<cmd>lua Snacks.terminal.toggle()<CR>")
vim.keymap.set("t", "<F4>", "<C-\\><C-n><cmd>lua Snacks.terminal.toggle()<CR>")
vim.keymap.set("t", "<F5>", "<C-\\><C-n><cmd>lua Snacks.terminal.toggle()<CR>")
vim.keymap.set("n", "<leader>n", "<cmd>lua Snacks.notifier.show_history()<CR>")

-- vim.cmd("autocmd Filetype netrw <cmd>Vifm")
-- terminal
-- vim.cmd("autocmd Filetype term nnoremap <F5> <cmd>lua Snacks.terminal.toggle()<CR>")
-- markdown
-- vim.cmd("autocmd FileType markdown vmap <F5> <cmd>!column -t -s '|' -o '|'")

vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf",
	callback = function()
		vim.keymap.set("n", "j", "<cmd>cnext<CR>", { buffer = true })
		vim.keymap.set("n", "<k>", "<cmd>cprev<CR>", { buffer = true })
	end

})
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		-- vim.keymap.set("n", "<C-p>", "<cmd>lua require('nabla').popup()<CR>", { buffer = true })
		vim.keymap.set("n", "<F5>", "<cmd>lua require('nabla').enable_virt({autogen = true, silent = true,})<CR>",
			{ buffer = true })
		vim.keymap.set("n", "<F6>", "<cmd>!pandoc --wrap=preserve % -o ~/Documents/%:t:r.pdf<CR>",
			{ buffer = true })
		vim.api.nvim_buf_create_user_command(
			0,
			"Backup",
			"!git add . && git commit -a -m \"vault backup: " .. os.date("%Y-%m-%d %H:%M:%S") .. "\" && git push",
			{}
		)
	end

})
-- rmarkdown
vim.api.nvim_create_autocmd("FileType", {
	pattern = "rmarkdown",
	callback = function()
		vim.keymap.set("n", "<F6>", "<cmd>RSend rmarkdown::render('" .. vim.fn.expand('%:p') .. "')<CR>",
			{ buffer = true })
	end
})
-- Python
vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = function()
		vim.keymap.set("n", "<C-F5>",
			":lua Snacks.terminal.toggle()<CR>python3 -m pdb" .. vim.fn.expand('%:p') .. "<CR>",
			{ buffer = true })
		vim.keymap.set("i", "<C-F5>", "<esc><cmd>lua Snacks.terminal.toggle()<CR>python3 -m pdb " ..
			vim.fn.expand('%:p') .. "<CR>", { buffer = true })
		vim.keymap.set("n", "<F5>", "<cmd>lua Snacks.terminal.toggle()<CR>python3 " ..
			vim.fn.expand('%:p') .. "<CR>", { buffer = true })
		vim.cmd("i", "<F5>", "<esc><cmd>w <cmd>lua Snacks.terminal.toggle()<CR>python3 " ..
			vim.fn.expand('%:p') .. "<CR>", { buffer = true })
	end

})
-- Rust
vim.api.nvim_create_autocmd("FileType", {
	pattern = "rust",
	callback = function()
		vim.keymap.set("n", "<C-F5>", "<cmd>lua Snacks.terminal.toggle()<CR>cargo build; rust-gdb " ..
			vim.fn.expand('%:p:h:h') .. "/target/debug/" .. vim.fn.expand('%:p:h:h:t') .. "<CR>",
			{ buffer = true })
		vim.keymap.set("n", "<F5>",
			"<cmd>lua Snacks.terminal.toggle()<CR>cargo run<CR>",
			{ buffer = true })
		vim.keymap.set("n", "<F6>",
			"<cmd>lua Snacks.terminal.toggle(\"cargo build;read '?Press enter to continue...'\", {win = {position = \"bottom\"}})<CR>" ..
			vim.fn.expand("%") .. "\";;<CR>", { buffer = true })
	end
})
-- OCaml
vim.api.nvim_create_autocmd("FileType", {
	pattern = "ocaml",
	callback = function()
		vim.keymap.set("n", "<F5>", "<cmd>lua Snacks.terminal.toggle()<CR>dune run<CR>", { buffer = true })
		vim.keymap.set("n", "<F6>",
			"<cmd>lua Snacks.terminal.toggle(\"dune build;read '?Press enter to continue...'\", {win = {position = \"bottom\"}})<CR>",
			{ buffer = true })
		vim.keymap.set({ "t", "n" }, "<F7>",
			"<cmd>lua Snacks.terminal.toggle(\"utop\", {win = {position = \"bottom\"}})<CR>;;<CR>#use \"" ..
			vim.fn.expand("%") .. "\";;<CR>", { buffer = true })
		vim.keymap.set("t", "<F7>", "<cmd>lua Snacks.terminal.toggle('utop')<CR>")
		vim.keymap.set("t", "kj", "<esc>")
	end
})
-- Java
-- vim.cmd("autocmd FileType java nnoremap <F5> :w<CR>:cd %:p:h<CR>:cd ../<CR>:split<CR>:res -20<CR>:terminal java %<CR>")
-- CPP
-- vim.cmd(
-- 	"autocmd FileType cpp nnoremap <F5> :w<CR>:!cd %:p:h<CR>:split<CR>:res -20<CR>:terminal multipass exec -d /home/ubuntu/%:p:gs?/home/maxdu?Home?:h primary make; multipass exec -d /home/ubuntu/%:p:gs?/home/maxdu?Home?:h primary ./%:t:r ")
-- vim.cmd(
-- 	"autocmd FileType cpp nnoremap <F7> :w<CR>:!cd %:p:h<CR>:split<CR>:res -20<CR>:terminal multipass exec -d /home/ubuntu/%:p:gs?/home/maxdu?Home?:h primary make; multipass exec -d /home/ubuntu/%:p:gs?/home/maxdu?Home?:h primary ")
-- -- Racket/scheme
-- -- 	Use F6 to run in REPL
-- vim.cmd("autocmd FileType eopl set filetype=scheme")
-- vim.cmd("autocmd FileType racket set filetype=scheme")
-- vim.cmd("autocmd FileType scheme inoremap <F5><esc>:w<CR>:split<CR>:res -20<CR>:terminal racket %<CR>")
-- vim.cmd("autocmd FileType scheme inoremap <F5> <esc>:w<CR>:split<CR>:res -20<CR>:terminal racket %<CR>")
-- vim.cmd(
-- 	"autocmd FileType scheme inoremap <F6> <esc>:w<CR>:split<CR>:res -20<CR>:terminal racket -i -f <(tail -n +2 %)<CR>")
-- vim.cmd("autocmd FileType scheme nnoremap <F6> :w<CR>:split<CR>:res -20<CR>:terminal racket -i -f <(tail -n +2 %)<CR>")
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

vim.keymap.set("n", "<Tab>", "<cmd>lua SwitchToNextWindow()<CR>", { silent = true })
vim.keymap.set("n", "<leader><Tab>", "<cmd>b#<CR>", { silent = true })

vim.cmd("autocmd FileType markdown set conceallevel=2")
vim.cmd("autocmd FileType markdown setlocal spell")
vim.cmd("autocmd FileType markdown set spelllang=en_us")
vim.cmd("autocmd FileType markdown inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u")
vim.cmd("Alias os ObsidianQuickSwitch")
vim.cmd("Alias obs ObsidianSearch")
vim.cmd("Alias oo ObsidianOpen")
vim.cmd("Alias od ObsidianToday")
vim.cmd("Alias notes vsplit|ObsidianQuickSwitch")
vim.cmd("Alias nts vsplit|ObsidianQuickSwitch")
