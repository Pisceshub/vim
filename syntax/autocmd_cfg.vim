augroup NERDTree
    au!
    autocmd VimEnter * 
				\	NERDTree   " vim启动时自动打开NERDTree 

    autocmd StdinReadPre * 
				\	let s:std_in = 1

    autocmd VimEnter * 
				\	if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") |
				\		exe 'NERDTree' argv()[0] |
				\	wincmd p |
				\		ene |
				\	endif

    " 文件全部关闭时退出NERDTree
	autocmd bufenter * 
				\	if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTree.isTabTree()) |
				\		q |
				\	endif
augroup END  



autocmd VimEnter * 
   \	wincmd w
"     autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" map <C-n> :NERDTreeToggle<CR>


augroup init
    autocmd!

    " 代码折叠
    autocmd FileType vim setlocal foldmethod=marker

    " 打开文件时，恢复上一次关闭文件时光标所在行
    "autocmd BufReadPost * if line(---'\------) > 1 && line(---'\------) <= line(---$---) | execute ---normal! g'\------ | endif

augroup END
autocmd FocusGained,BufEnter * checktime
autocmd BufRead,BufNewFile *.sv,*.svh,*.log,*.err,*.trace set filetype=systemverilog
