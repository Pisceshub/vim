""""""""""""""""""""""""""""""""""""""""""""""""
""Add File Header settings
"文件头生成
""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufNewFile *.v,*.sv,*.cpp,*.c,*.h exec":call AddvHeader()"


function s:GetUserName()
    let user_names = $USER
    return user_names
endfunction
function s:GetUserEmail()
    let user_emails = $USER . ".com"
    return user_emails
endfunction

function AddvHeader()
    let line = getline(1)
    let filename = expand("%:t")
	call append(0,  "// ==================================================" )
    call append(1,  "// Copyright (c)"                                      )
    call append(2,  "// All rights reserved"                                )
    call append(3,  "// Filename      : ".filename                          )
    call append(4,  "// Author        : ".s:GetUserName()                   )
	call append(5,  "// Email         : ".s:GetUserEmail()                  )
    call append(6,  "// Created on    : ".strftime("%Y-%m-%d %H:%M:%S")     )
    call append(7,  "// Last modified : "                                   )
    call append(8,  "// Description   : "                                   )
    call append(9,  "// "                                                   )
    call append(10, "// "                                                   )
    call append(11, "// ==================================================" )
endfunction
autocmd BufNewFile *.py  exec":call AddpHeader()"   
function AddpHeader()
    let line = getline(1)
    let filename = expand("%:t")
	call append(0,  "# ==================================================" )
    call append(1,  "# Copyright (c)"                                      )
    call append(2,  "# All rights reserved"                                )
    call append(3,  "# Filename      : ".filename                          )
    call append(4,  "# Author        : ".s:GetUserName()                   )
	call append(5,  "# Email         : ".s:GetUserEmail()                  )
    call append(6,  "# Created on    : ".strftime("%Y-%m-%d %H:%M:%S")     )
    call append(7,  "# Last modified : "                                   )
    call append(8,  "# Description   : "                                   )
    call append(9,  "# "                                                   )
    call append(10, "# "                                                   )
    call append(11, "# ==================================================" )
endfunction
""""""""""""""""""""""""""""""""""""""""""""""""
""ModufyTime
""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufWritePre *.v,*.sv,*.cpp,*.c,*.h :call UpdateLastModifyTime()"

function UpdateLastModifyTime()
    let line = getline(8)
    if line =~'// Last modified : '
        call setline(8,"// Last modified : ".strftime("%Y-%m-%d %H:%M:%S"))
    endif
endfunction
autocmd BufWritePre *.py :call PyUpdateLastModifyTime()"

function PyUpdateLastModifyTime()
    let line = getline(8)
    if line =~'# Last modified : '
        call setline(8,"# Last modified : ".strftime("%Y-%m-%d %H:%M:%S"))
    endif
endfunction

function UpdateSvTags()
    silent! execute '!ctags -f /home/ICer/ic_prjs/riscv/digital_data/verifaction/ctags/rtl_tags -L /home/ICer/ic_prjs/riscv/digital_data/src/riscv/filelist.v --languages=systemverilog'
    silent! execute '!ctags -R  -f /home/ICer/ic_prjs/riscv/digital_data/verifaction/ctags/uvm_tags /home/synopsys/vcs-mx/O-2018.09-SP2/etc/uvm-1.1'
endfunction

