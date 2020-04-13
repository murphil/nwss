set nocompatible

set guifont=Source_Code_Pro:h11:w7
set linespace=2

syntax on
colorscheme desert

"简洁启动模式
set shortmess=atI
"set guioptions=gmrLtT  m:菜单 T:工具栏 r:滚动条
set guioptions=gLt
"  "状态栏样式
"  set laststatus=2
"    function! CurDir()
"       let curdir = substitute(getcwd(), '/Users/amir/', "~/", "g")
"       return curdir
"    endfunction
"  set statusline=\ %F%m%r%h\ [%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c
"在状态栏位置显示补全菜单
set wildmenu
set cmdheight=1
set ruler

"显示不完整的段落
set display=lastline
"自动折行
set wrap
"按完整单词折行
set nolinebreak
"行宽（输入时自动插入换行符）
set textwidth=0
"j k 在屏幕行间上下移动；gj gk 在物理行间上下移动
noremap j gj
noremap k gk
noremap gj j
noremap gk k
"使用 Space 作为 leader
let mapleader="\<Space>"


set expandtab
set tabstop=4
set shiftwidth=4
set autoindent
"插入模式下，“←”如何删除光标前的字符：行首空白、换行符、插入点之前的字符
set backspace=indent,eol,start
"粘贴模式
"set paste "set nopaste

"命令行历史纪录
set history=500

"禁用增量搜索
set incsearch
"set noincsearch
"搜索时忽略大小写
set ignorecase
"set noignorecase
"高亮显示搜索结果
set hlsearch

"设定折叠方式
"set foldmethod=manual

"以下字符将被视为单词的一部分 (ASCII)：
"set iskeyword+=33-47,58-64,91-96,123-128

"记忆最后编辑状态
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
set viminfo='1000,f1,<500

chdir $VIM/..

if has('gui_running') && has("win32")
    map <F11> :call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
endif
