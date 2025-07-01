" 加载字体
" mkdir -p ~/.local/share/fonts
" cp ~/vim/bundle/DroidSansMNerdFontMono-Regular.otf ~/.local/share.fonts/


"""""""""""""""""""""""""""""""""""""""""""""""
"vim-plug settings
""插件管理的插件
"""""""""""""""""""""""""""""""""""""""""""""""
"加载插件管理插件 
source  ~/vim/autoload/vim-plug/plug.vim  
call plug#begin('~/.vim/bundle')
    Plug 'preservim/nerdtree'
    Plug 'scrooloose/nerdcommenter'
    Plug 'mhinz/vim-startify'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'yggdroot/indentline'
    Plug 'w0ng/vim-hybrid'
    "Plug 'w0rp/ale'
    Plug 'universal-ctags/ctags'
    Plug 'SirVer/ultisnips'
    Plug 'keelii/vim-snippets'
    Plug 'Shougo/neocomplcache.vim'
    Plug 'junegunn/vim-easy-align'
	Plug 'vim-scripts/vlog_inst_gen'
	Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    "Plug 'ryanoasis/vim-devicons'
    Plug 'mhinz/vim-signify'
    Plug 'vhda/verilog_systemverilog.vim'
    Plug 'HonkW93/automatic-verilog'
    "Plug 'ycm-core/YouCompleteMe'
    "Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'npm ci'}
    Plug 'gregsexton/gitv', 
    Plug 'tpope/vim-fugitive'
    Plug 'simnalamburt/vim-mundo'
    Plug '~/.vim/bundle/vim-gutentags-master'
call plug#end()


"filetype on：启用文件类型检测。
"plugin on：加载文件类型相关的插件。
"indent on：加载文件类型相关的缩进规则。
filetype plugin indent on


""""""""""""""""""""""""""""""""""""""""""""""""
""snippet.vim settings
" 代码片段插件
""""""""""""""""""""""""""""""""""""""""""""""""
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsListSnippets = "<c-tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<S-tab>"


""""""""""""""""""""""""""""""""""""""""""""""""
""nerdcommenter settings
" 注释插件,cc ,cu ,cA
""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ","


""""""""""""""""""""""""""""""""""""""""""""""""
""neocomplcache settings
" 补全插件
""""""""""""""""""""""""""""""""""""""""""""""""
" 在系统启动时启动neo
let g:neocomplcache_enable_at_startup  = 1
" 提示的时候默认选择地一个，如果设为0 每次输入都是需要上下键选择
let g:neocomplcache_enable_auto_select = 1


""""""""""""""""""""""""""""""""""""""""""""""""
""verilog_inst_gen settings
"例化插件 指令是",ig"
""""""""""""""""""""""""""""""""""""""""""""""""
"so ~/vim/bundle/vlog_inst_gen/vlog_inst_gen.vim 
let g:vlog_inst_gen_mode=2 "copy to clipboard and echo inst in split window


""""""""""""""""""""""""""""""""""""""""""""""""
""vim-devicons settings
""""""""""""""""""""""""""""""""""""""""""""""""
set runtimepath+=~/.vim/bundle/vim-devicons-master
set encoding=UTF-8
"Can be enabled or disabled
let g:webdevicons_enable_nerdtree = 1

"whether or not to show the nerdtree brackets around flags
let g:webdevicons_conceal_nerdtree_brackets = 1

"adding to vim-airline's tabline
let g:webdevicons_enable_airline_tabline = 1

"adding to vim-airline's statusline
let g:webdevicons_enable_airline_statusline = 1



set nocompatible
filetype plugin indent on

"""
" git config --global alias.st status
" 

let g:atv_snippet_project = 'riscv'
"let g:atv_snippet_company = "Huawei.HS"
let g:atv_snippet_device = ""
let g:atv_snippet_author = "x00897025"
let g:atv_snippet_email = ""
let g:atv_snippet_website = ""
"let g:atv_snippet_albpp_file = '~/.vim/template.v'
" 设置 Git 命令的默认行为
let g:fugitive_git_executable = 'git'
set statusline+=%{FugitiveStatusline()}
" 设置 Git 命令的输出格式
let g:fugitive_output_format = 'buffer'
" Enable persistent undo so that undo history persists across vim sessions
set undofile
set undodir=~/.vim/undodir


""""""""""""""""""""""""""""""""""""""""""""""""
""gutentags settings
""""""""""""""""""""""""""""""""""""""""""""""""

" gutentags搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归 "
let g:gutentags_project_root = ['.root', '.svn', '.git', '.project']

" 所生成的数据文件的名称 "
let g:gutentags_ctags_tagfile = '.tags'

" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录 "
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
" 检测 ~/.cache/tags 不存在就新建 "
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif

" 配置 ctags 的参数 "
"let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
"let g:gutentags_ctags_extra_args += ['--c++-kinds=+pxI']
"let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
