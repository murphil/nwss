set nocompatible
" 简洁启动模式
set shortmess=atI

syntax on
colorscheme koehler

" 在状态栏位置显示补全菜单
set wildmenu
set number
set ruler
"set cmdheight=1
"set linespace=2

" 显示不完整的段落
set display=lastline
" 自动折行
set wrap
" 按完整单词折行
set nolinebreak
" 行宽（输入时自动插入换行符）
set textwidth=0

" 使用 Space 作为 leader
let mapleader="\<Space>"


set shiftwidth=4
set expandtab
set softtabstop=-1
set autoindent
" 插入模式下，“←”如何删除光标前的字符：行首空白、换行符、插入点之前的字符
set backspace=indent,eol,start

" 命令行历史纪录
set history=500

" 禁用增量搜索
set incsearch
" 搜索时忽略大小写
set ignorecase
" 高亮显示搜索结果
set hlsearch
" 清除高亮
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

" 设定折叠方式
set foldmethod=marker

" 以下字符将被视为单词的一部分 (ASCII)：
"set iskeyword+=33-47,58-64,91-96,123-128

" 记忆最后编辑状态
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
set viminfo='1000,f1,<500

" bracketed-paste.vim
if exists("g:loaded_bracketed_paste")
  finish
endif
let g:loaded_bracketed_paste = 1

let &t_ti .= "\<Esc>[?2004h"
let &t_te = "\e[?2004l" . &t_te

function! XTermPasteBegin(ret)
  set pastetoggle=<f29>
  set paste
  return a:ret
endfunction

execute "set <f28>=\<Esc>[200~"
execute "set <f29>=\<Esc>[201~"
map <expr> <f28> XTermPasteBegin("i")
imap <expr> <f28> XTermPasteBegin("")
vmap <expr> <f28> XTermPasteBegin("c")
cmap <f28> <nop>
cmap <f29> <nop>

