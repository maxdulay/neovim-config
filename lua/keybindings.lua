vim.cmd("inoremap kj <Esc>")
vim.cmd("tnoremap kj <C-\\><C-n>")
vim.cmd("nmap <C-u> <C-u>zz<CR>")
vim.cmd("nmap <C-d> <C-d>zz<CR>")
vim.cmd("nnoremap <C-n> :NERDTreeFocus<CR>")
vim.cmd("nnoremap <C-t> :NERDTreeToggle<CR>")
vim.cmd("Alias vs vs|edit<Space>%:p:h")
vim.cmd("Alias ff Telescope<Space>find_files")
vim.cmd("Alias qq bd!")
vim.cmd("nmap <C-l> <C-w>l")
vim.cmd("nmap <C-j> <C-w>j")
vim.cmd("nmap <C-k> <C-w>k")
vim.cmd("nmap <C-h> <C-w>h")
vim.cmd("Alias bl BufferLinePick")
vim.cmd("nnoremap <F4> :split<CR>:res -20<CR>:terminal<CR>")
vim.cmd("inoremap <F4> <esc>:split<CR>:res -20<CR>:terminal<CR>")
-- Python
vim.cmd("autocmd FileType python nnoremap <F5> :w<CR>:split<CR>:res -20<CR>:terminal ~/python/bin/python %<CR>")
vim.cmd("autocmd FileType python inoremap <F5> <esc>:w<CR>:split<CR>:res -20<CR>:terminal ~/python/bin/python %<CR>")
-- Java
vim.cmd("autocmd FileType java nnoremap <F5> :w<CR>:split<CR>:res -20<CR>:terminal java %<CR>")
vim.cmd("autocmd FileType java inoremap <F5> <esc>:w<CR>:split<CR>:res -20<CR>:terminal java %<CR>")
-- Racket/scheme
-- 	Use F6 to run in REPL
vim.cmd("autocmd FileType eopl set filetype=scheme")
vim.cmd("autocmd FileType racket nnoremap <F5> :w<CR>:split<CR>:res -20<CR>:terminal racket %<CR>")
vim.cmd("autocmd FileType racket nnoremap <F5> :w<CR>:split<CR>:res -20<CR>:terminal racket %<CR>")
vim.cmd("autocmd FileType scheme inoremap <F5> <esc>:w<CR>:split<CR>:res -20<CR>:terminal racket %<CR>")
vim.cmd("autocmd FileType scheme inoremap <F5> <esc>:w<CR>:split<CR>:res -20<CR>:terminal racket %<CR>")
vim.cmd("autocmd FileType scheme inoremap <F6> <esc>:w<CR>:split<CR>:res -20<CR>:terminal racket -i -f <(tail -n +2 %)<CR>")
vim.cmd("autocmd FileType scheme nnoremap <F6> :w<CR>:split<CR>:res -20<CR>:terminal racket -i -f <(tail -n +2 %)<CR>")

-- markdown 
-- vim.cmd("autocmd FileType markdown vmap <F5> :!column -t -s '|' -o '|'")
