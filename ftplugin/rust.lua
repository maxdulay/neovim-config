vim.cmd("autocmd FileType rust nnoremap <C-F5> :lua Snacks.terminal.toggle()<CR>cargo build; rust-gdb " .. vim.fn.expand('%:p:h:h') .. "/target/debug/" .. vim.fn.expand('%:p:h:h:t') .. "<CR>")
vim.cmd("autocmd FileType rust nnoremap <F5> :lua Snacks.terminal.toggle()<CR>cargo run<CR>")
vim.cmd("autocmd FileType rust nnoremap <F6> :lua Snacks.terminal.toggle(\"cargo build;read '?Press enter to continue...'\", {win = {position = \"bottom\"}})<CR>")
