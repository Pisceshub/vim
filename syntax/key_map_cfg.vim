""""""""""""""""""""""""""""""""""""""""""""""""
""easyalign settings
" 对齐插件
""""""""""""""""""""""""""""""""""""""""""""""""
" Start interactive EasyAlign in visual mode (eg vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/txt object (eg gaip)
nmap ga <Plug>(EasyAlign)

"""""""""""""""""""""""""""""""""""""""""""""""
"NERDTree settings
"显示目录的插件
"""""""""""""""""""""""""""""""""""""""""""""""
map <leader>ne :NERDTreeToggle<CR>     
",ne"
map <F2> :NERDTreeMirror<CR>
map <F2> :NERDTreeToggle<CR>

map <leader>gdh :SignifyToggle<CR>
" 显示当前更改的详细 diff
map <Leader>gl :SignifyHunkDiff<CR>

"""""""""""""""""""""""""""""""""""""""""""""""
" file Header
" 文件头信息
"""""""""""""""""""""""""""""""""""""""""""""""
map <leader>fv :call AddvHeader()<CR>
map <leader>fp :call AddpHeader()<CR>
map <leader>ct :call UpdateSvTags()<CR>


"分屏调转
nmap <c-h> <c-w>h
nmap <c-j> <c-w>j
nmap <c-k> <c-w>k
nmap <c-l> <c-w>l


" 映射 j 和 k，使其在没有计数时使用 gj 和 gk
nmap <expr> j (v:count ? 'j' : 'gj')
nmap <expr> k (v:count ? 'k' : 'gk')






"分屏大小控制
"nmap <up> :res +5<cr>
"nmap <down> :res -5<cr>
"nmap <left> :vertical resize-5<cr>
"nmap <right> :vertical resize+5<cr>
 "标签新建和关闭
nmap <leader>tt :tabnew<cr>
nmap <leader>tn :tabNext<cr>
nmap <leader>tp :tabprevious<cr>
nmap <leader>tc :tabclose<cr>

