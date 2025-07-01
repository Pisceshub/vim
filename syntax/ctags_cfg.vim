""""""""""""""""""""""""""""""""""""""""""""""""
"" ctags 跳转 settings
" 使用filelist去生成指定ctags
""""""""""""""""""""""""""""""""""""""""""""""""
" ctags -f /home/ICer/ic_prjs/riscv/digital_data/verifaction/ctags/rtl_tags -L /home/ICer/ic_prjs/riscv/digital_data/src/riscv/filelist.f --languages=systemverilog
" ctags -R  -f /home/ICer/ic_prjs/riscv/digital_data/verifaction/ctags/uvm_tags /home/synopsys/vcs-mx/O-2018.09-SP2/etc/uvm-1.2
" ctags -f /home/ICer/ic_prjs/riscv/digital_data/verifaction/ctags/env_tags -L /home/ICer/ic_prjs/riscv/digital_data/verifaction/st/cfg/tb.f --languages=systemverilog
" 自动更新 ctags
"autocmd BufWritePost *.v,*.vg,*.sv,*.svh,*.tv,*.vinc,*.h silent! !ctags -u -f /home/ICer/ic_prjs/riscv/digital_data/verifaction/ctags/rtl_tags -L /home/ICer/ic_prjs/riscv/digital_data/src/riscv/filelist.f 


 
"set tags=/home/ICer/ic_prjs/riscv/digital_data/verifaction/ctags/rtl_tags
"set tags+=/home/ICer/ic_prjs/riscv/digital_data/verifaction/ctags/git_rtl_tags
"set tags+=/home/ICer/ic_prjs/riscv/digital_data/verifaction/ctags/uvm_tags


"set nocompatible
"filetype plugin indent on

" 自动更新 ctags 仅对修改过的文件
"augroup UpdateCTags
    "autocmd!
    "autocmd BufWritePost *.v,*.vg,*.sv,*.svh,*.tv,*.vinc,*.h call UpdateCTags()
"augroup END



function! UpdateCTags()
    " 检查当前目录是否为 Git 仓库
    if !empty(system('git rev-parse --is-inside-work-tree 2>/dev/null'))
        " 记录开始时间
        let start_time = reltime()

        " 获取修改的文件列表
        let modified_files = system('git ls-files --modified --others --exclude-standard | grep -E "\.v$|\.vg$|\.sv$|\.svh$|\.tv$|\.vinc$|\.h$" | sed "s|^|$(pwd)/|"')

        " 读取 filelist.f 中的文件
        let filelist_path = '/home/ICer/ic_prjs/riscv/digital_data/src/riscv/filelist.f'
        let filelist_files = readfile(filelist_path)

        " 筛选出在 filelist 中的修改文件
        let files_to_update = []
        for file in split(modified_files, '\n')
            if file =~# '\.v$' || file =~# '\.vg$' || file =~# '\.sv$' || file =~# '\.svh$' || file =~# '\.tv$' || file =~# '\.vinc$' || file =~# '\.h$'
                " 检查是否在 filelist 中
                if index(filelist_files, file) != -1
                    call add(files_to_update, file)
                endif
            endif
        endfor
        echom files_to_update
        " 更新 ctags
        if !empty(files_to_update)
            silent! execute 'cd ' . git_root
            silent! execute '!ctags -a -f /home/ICer/ic_prjs/riscv/digital_data/verifaction/ctags/rtl_tags ' . join(files_to_update)
        endif

        " 计算和输出执行时间
        let elapsed_time = reltimefloat(reltime(start_time))
        echom "Update ctags completed in " . elapsed_time . " seconds."
    else
        echom "No Git repository found. Skipping ctags update."
    endif
endfunction
