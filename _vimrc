" ProjectLink: https://github.com/gowiden/vimrc
" Author:  Todd
" Page: https://about.me/vimer
" Last_modify: 2012-02-02
" Desc: simple configures, without plugins.

source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

" leader
let mapleader = ','
let g:mapleader = ','

" syntax
syntax on

" history : how many lines of history VIM has to remember
set history=2000

" filetype
filetype on
" Enable filetype plugins
filetype plugin on
filetype indent on
filetype plugin indent on
syntax enable

" base
set nocompatible                " don't bother with vi compatibility
set autoread                    " 文件修改之后自动载入。
set shortmess=atI               " 启动的时候不显示那个援助索马里儿童的提示
set cm=blowfish
set magic                       " For regular expressions turn magic on
set title                       " change the terminal's title
set nobackup                    " do not keep a backup file
set noswapfile                  " 关闭交换文件
set novisualbell                " turn off visual bell
set noerrorbells                " don't beep
"set visualbell t_vb=           " turn off error beep/flash
set t_vb=
set tm=500

" show location
set nocursorcolumn              " 突出显示当前行等 不喜欢这种定位可注解
set cursorline                  " 突出显示当前行
set gcr=a:block-blinkon0

" movement
set scrolloff=7                 " keep 3 lines when scrolling

" show
set ruler                       " show the current row and column
set number                      " show line numbers
set wrap
set showcmd                     " display incomplete commands
set showmode                    " display current modes
set showmatch                   " jump to matches when entering parentheses
set matchtime=2                 " tenths of a second to show the matching parenthesis
set ambiwidth=double            " 对不明宽度字符的处理方式
"set guifont=Bitstream\ Vera\ Sans\ Mono\ 11
"set guifont=Fixedsys:h10:cGB2312
set guifont=YaHei\ Mono:h10
set lz                          " 运行宏时不重绘屏幕
set columns=90
set lines=28
set winaltkeys=no               " 不用alt键访问菜单
set nolinebreak                 " 禁用断行
set t_ti= t_te=
set t_Co=256

" search
set hlsearch                    " highlight searches
set incsearch                   " do incremental searching, search as you type
set ignorecase                  " ignore case when searching
set smartcase                   " no ignorecase if Uppercase char present

" 选中一段文字并全文搜索这段文字
vnoremap  *  y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>
vnoremap  #  y?<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>

" tab
set expandtab                   " expand tabs to spaces
set smarttab
set shiftround

" indent
set autoindent smartindent shiftround
set shiftwidth=4
set tabstop=4
set softtabstop=4               " insert mode tab and backspace use 4 spaces

" NOT SUPPORT
" fold
set foldenable
set foldmethod=syntax
set foldlevel=6
set foldcolumn=0
let g:FoldMethod = 0
map <leader>zz :call ToggleFold()<cr>
fun! ToggleFold()
    if g:FoldMethod == 0
        exe "normal! zM"
        let g:FoldMethod = 1
    else
        exe "normal! zR"
        let g:FoldMethod = 0
    endif
endfun

" encoding
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set termencoding=utf-8
set helplang=cn
set formatoptions+=m      "如遇Unicode值大于255的文本，不必等到空格再折行。
set formatoptions+=B      "合并两行中文时，不在中间加空格：
set textwidth=80
set fileformat=unix
set fileformats=dos,unix,mac  " ffs=dos,unix

" select & complete
set selection=inclusive
set selectmode=mouse,key

set completeopt=longest,menu
set wildmenu                  " show a navigable menu for tab completion"
set wildmode=longest,list,full
set wildignore=*.o,*~,*.pyc,*.class
set nrformats=                " 00x增减数字时使用十进制

" others
set backspace=indent,eol,start  " make that backspace key work the way it should
set whichwrap+=<,>,h,l

" Vimrc Auto
autocmd! bufwritepost _vimrc source %
"autocmd! bufwritepost .vimrc source %

" if this not work ,make sure .viminfo is writable for you
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" NOT SUPPORT
" Enable basic mouse behavior such as resizing buffers.
set mouse-=a

" TODO: smart <Home>

function! RemoveTrailingWhitespace()
    if &ft != "diff"
        let b:curcol = col(".")
        let b:curline = line(".")
        silent! %s/\s\+$//
        silent! %s/\(\s*\n\)\+\%$//
        call cursor(b:curline, b:curcol)
    endif
endfunction
autocmd BufWritePre * call RemoveTrailingWhitespace()

" delete ^M
nmap <leader>dm mmHmn:%s/<C-V><CR>//ge<CR>'nzt'm

" Remove trailing whitespace when writing a buffer, but not for diff files.
autocmd BufWritePre * :%s/\s\+$//e
autocmd BufWritePre * %s/^$\n\+\%$//ge
au BufWritePre * exe 'sil! 1,' . min([line('$'), 20]) . 's/^\S\+\s\+Last modified: \zs.*/\=strftime("%y-%m-%d %H:%M:%S")/e'

" ======================= theme and status line =========================

" theme
set background=dark
colorscheme desert

" set mark column color
hi! link SignColumn   LineNr
hi! link ShowMarksHLl DiffAdd
hi! link ShowMarksHLu DiffChange

" @see http://liyanrui.is-programmer.com/articles/1791/gvim-menu-and-toolbar-toggle.html
set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=L
map <silent> <F2> :if &guioptions =~# 'T' <Bar>
\set guioptions-=T <Bar>
\set guioptions-=m <bar>
\else <Bar>
\set guioptions+=T <Bar>
\set guioptions+=m <Bar>

set autochdir
set colorcolumn=80

hi colorcolumn guibg=#444444
"hi ColorColumn ctermbg=gray guibg=gray
"syn match out80 /\%80v./ containedin=ALL
"hi out80 guifg=#333333 guibg=#ffffff

" status line
set laststatus=2  " Always show the status line - use 2 lines for the status bar
" 设置状态栏显示内容
set statusline=%t\ %1*%m%*\ %1*%r%*\ %2*%h%*%w%=%l%3*/%L(%p%%)%*,%c%V]\ [%b:0x%B]\ [%{&ft==''?'TEXT':toupper(&ft)},%{toupper(&ff)},%{toupper(&fenc!=''?&fenc:&enc)}%{&bomb?',BOM':''}%{&eol?'':',NOEOL'}]
hi User1 guibg=red guifg=yellow
hi User2 guibg=#008000 guifg=white
hi User3 guibg=#C2BFA5 guifg=#999999

" F11 maximize window
"if has("gui_running") && has("win32")
"    map <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
"endif

" ============================ Mappings ================================
" Normal Mode, Visual Mode, and Select Mode,
" use <Tab> and <Shift-Tab> to indent
" @see http://c9s.blogspot.com/2007/10/vim-tips.html
"nmap <tab> v>                  " :h ctrl-i :h <tab>
"nmap <s-tab> v<
vmap <tab> >gv
vmap <s-tab> <gv

" 窗口间的移动设置
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-l> <C-W>l
map <C-h> <C-W>h

map <C-kPlus> <C-w>+
map <C-kMinus> <C-w>-
map <C-S-kPlus> <C-w>_
map <C-S-kMinus> <C-w>_

map <C-c> "+y
map <C-v> "+p

" TODO: smart <Home>

function! RemoveTrailingWhitespace()
    if &ft != "diff"
        let b:curcol = col(".")
        let b:curline = line(".")
        silent! %s/\s\+$//
        silent! %s/\(\s*\n\)\+\%$//
        call cursor(b:curline, b:curcol)
    endif
endfunction
autocmd BufWritePre * call RemoveTrailingWhitespace()

" ========================= specific file type ===========================

autocmd FileType python set tabstop=4 shiftwidth=4 expandtab ai
autocmd FileType ruby set tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai
autocmd BufRead,BufNew *.md,*.mkd,*.markdown  set filetype=markdown.mkd

autocmd BufNewFile *.sh,*.py exec ":call AutoSetFileHead()"
function! AutoSetFileHead()
    " .sh
    if &filetype == 'sh'
        call setline(1, "\#!/bin/bash")
    endif

    " python
    if &filetype == 'python'
        call setline(1, "\#!/usr/bin/env python")
        call append(1, "\# encoding: utf-8")
    endif

    normal G
    normal o
    normal o
endfunc

autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
