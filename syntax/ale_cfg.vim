"""""""""""""""""""""""""""""""""""""""""""""""
"ale.vim settings
"语法检查插件
"""""""""""""""""""""""""""""""""""""""""""""""
" keep the sign gutter open
let g:ale_sign_column_always =1
let g:ale_sign_error = ">>"
let g:ale_sign_warning = '--'

"show errors or warning in my statusline
let g:airline#extensions#ale#enabled = 1
" self-define statusline
" use quickfix list instead of the loclist
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1

" only enable these linters " 使用 iverilog 和 verilator 来检查 Verilog/SystemVerilog 文件

let g:ale_linters = {
\   'verilog':['hdl-checker','iverilog']
\}

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-k> <Plug>(ale_next_wrap)
" run lint only on saving a file
let g:ale_lint_on_text_changed = "never"
" dont run lint on opening a file
let g:ale_lint_on_enter = 0

" 启用实时 linter
"let g:ale_lint_on_text_changed = 'always'
"let g:ale_lint_on_insert_leave = 1
" 添加库文件路径，避免报错

let g:ale_verilog_iverilog_options =
    \    ' -sv -f /home/ICer/ic_prjs/riscv/digital_data/src/riscv/utils/def.inc' .
    \    ' /home/synopsys/vcs-mx/O-2018.09-1/etc/uvm-1.2/uvm_pkg.sv' 
" remove xvlog.vim 
    "\    ' -f /home/ICer/ic_prjs/riscv/digital_data/src/riscv/filelist.f'
    "\    ' -I /home/ICer/ic_prjs/riscv/digital_data/src/riscv/rtl' . 
    "\    ' -y /home/ICer/ic_prjs/riscv/digital_data/src/riscv/tb' .
    "\    ' -g2005-sv +incdir+/home/ICer/ic_prjs/uvm_hello' 
"\	'-g2005-sv +incdir+/home/ICer/ic_prjs/riscv/digital_data/src/riscv/include' .
let g:ale_log_to_file = 1
let g:ale_log_file_path = '/tmp/ale.log'
let g:ale_diagnostic_display_delay = 0
let g:ale_debug = 1


function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? 'OK' : printf(
    \   '%dW %dE',
    \   all_non_errors,
    \   all_errors
    \)
endfunction

set statusline=%{LinterStatus()}
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'




" 当退出 Vim 时删除特定的临时文件
autocmd VimLeave *.v,*.sv  silent! execute '!rm -r work xsim.dir xvlog.log xvlog.pb'

