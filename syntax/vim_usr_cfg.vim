"""""""""""""""""""""""""""""""""""""""""""""""
"vim  basic settings
"""""""""""""""""""""""""""""""""""""""""""""""
" 设置无交换文件
set noswapfile
" 语法高亮度显示
syntax on
" 光标显示
set nohidden
" 搜索匹配高亮
set hlsearch
" 搜索跳转
set incsearch
" 搜索忽略大小写 
set ignorecase 

" 打开自带的matchit插件，使 begin 和 end 关键字支持 % 跳转
packadd! matchit

" 行列高亮
"set cuc
"set cul

"hi CursorColumn guibg=LightGrey
"hi CursorLine ctermbg=NONE guibg=NONE
"hi CursorColumn ctermbg=NONE guibg=NONE

" 复制高亮
augroup YankHighlight
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank { higroup="IncSearch", timeout=200 }
augroup END


" 设置行号
set nu
set relativenumber 

" 自定义映射前缀
let mapleader = ","

" 防止中文注释乱码
set fileencoding=utf-8
set fenc=utf-8
set fencs=utf-8,usc-bom,euc-jp,gb18030,gbk,gb2312,cp936,big－5
set enc=utf-8
let &termencoding=&encoding

" 设置字体
set guifont=Monospace\ 10

" 设置tab4个空格
set tabstop=4
set expandtab

" 程序自动缩进时候空格数
set shiftwidth=4

" 退格键一次删除4个空格
set softtabstop=4
" 针对 make 文件设置 noexpandtab，即不将空格转换为制表符：
autocmd FileType make set noexpandtab

" 在编辑过程中，在右下角显示光标位置的状态行
set ruler


" vim使用自动对起，也就是把当前行的对起格式应用到下一行
set autoindent

" 依据上面的对起格式，智能的选择对起方式，对于类似C语言编写上很有用
"set smartindent

"避免在滑动时触发补全
set lazyredraw

" 在状态列显示目前所执行的指令
set showcmd

" 设置颜色主题
colorscheme desert

" 隐藏菜单栏
"set guioptions-=m

" 隐藏标题栏
set guioptions-=T

" gvim大小和位置 
if has("gui_running")
    winpos 235 235
	set lines=40 columns=108
endif


" 关闭 Vim 的兼容模式" 去除VI一致性，必须
set nocompatible

" 让backspace 键的行为更加灵活
" indent删除缩进，
" eol允许删除到上一行末尾
" start允许删除当前插入模式下的所有字符
set backspace=indent,eol,start

" 启用鼠标支持
"set mouse

"自动加载外部修改
set autoread

"使用 24 位 RGB 颜色
set termguicolors

" 不可见字符的显示，这里只把空格显示为一个点
"set list
"set listchars

 "无需按 Esc 键直接保存
set hidden


"禁用自动换行
"set nowrap

"允许光标自动换行
set whichwrap+=<,>,h,l

"允许光标移动到行尾
set virtualedit=block,onemore
"屏幕上下保留行，让眼睛能够看着屏幕中间
set scrolloff=2

"关闭自动文件类型检测，避免插件冲突
filetype off     " 必须

"使用系统剪辑版
set clipboard+=unnamedplus



" 双击ii
imap ii <ESC>



"重开文件跳转原来光标位置或末尾
au BufReadPost * 
	\	if line("'\"") > 0 && line("'\"") <= line("$")|
	\		exe "norm '\"" | 
	\	else|
	\		exe "norm $" |
	\	endif|

if has("nvim")
    echo "nvim"
    source ~/vim/syntax/vim_plug_start.vim
    source ~/vim/syntax/NERDTree_cfg.vim
    source ~/vim/syntax/file_header.vim
    source ~/vim/syntax/ale_cfg.vim
    source ~/vim/syntax/ctags_cfg.vim 
    source ~/vim/syntax/autocmd_cfg.vim 
    source ~/vim/syntax/key_map_cfg.vim 
    source ~/vim/syntax/git_signify.vim
    source ~/vim/syntax/myscolors.vim
    "source ~/vim/syntax/sc_highlight.vim
    "source ~/vim/syntax/systemverilog.vim
    source ~/vim/syntax/supercolors.vim

elseif has("gui_running")
    source ~/vim/syntax/vim_plug_start.vim
    source ~/vim/syntax/NERDTree_cfg.vim
    source ~/vim/syntax/file_header.vim
    source ~/vim/syntax/ale_cfg.vim
    source ~/vim/syntax/ctags_cfg.vim 
    source ~/vim/syntax/autocmd_cfg.vim 
    source ~/vim/syntax/key_map_cfg.vim 
    source ~/vim/syntax/git_signify.vim
    source ~/vim/syntax/myscolors.vim 
    "source ~/vim/syntax/sc_highlight.vim
    "source ~/vim/syntax/systemverilog.vim
    source ~/vim/syntax/supercolors.vim
else 
    echo "Running in vim"
endif 


