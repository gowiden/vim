"==========================================
" Author:  Todd <https://about.me/vimer>
" Last_modify: 2015-10-26
" Desc: simple vim config for server, without any plugins.
"==========================================
" General
if has("win32") || has("win32unix")
    let g:OS#name = "win"
    let g:OS#win = 1
    let g:OS#mac = 0
    let g:OS#unix = 0
elseif has("mac")
    let g:OS#name = "mac"
    let g:OS#mac = 1
    let g:OS#win = 0
    let g:OS#unix = 0
elseif has("unix")
    let g:OS#name = "unix"
    let g:OS#unix = 1
    let g:OS#win = 0
    let g:OS#mac = 0
endif

if has("gui_running")
    let g:OS#gui = 1
else
    let g:OS#gui = 0
endif

if g:OS#win
    source $VIMRUNTIME/vimrc_example.vim
    source $VIMRUNTIME/mswin.vim
    behave mswin
endif

" 禁止vim以兼容vi的模式运行
set nocompatible

" 启用插件和缩进
filetype plugin on
filetype indent on
filetype plugin indent on
syntax enable

" 语法高亮
syntax on
filetype on

" 配色方案
colorscheme desert

set guifont=Bitstream\ Vera\ Sans\ Mono\ 11
"set guifont=Fixedsys:h12:cGB2312

" 历史操作列表条数
set history=500

" 设定自动读取文件
set autoread

set cm=blowfish

"set t_ti= t_te=

" swrap file & auto backup
"if g:OS#win
"    set directory=$VIM\tmp
"else
"    set directory=~/.tmp
"endif

" 关闭自动备份
set nobackup

" 不使用交换文件
set noswapfile

" highlight CurrentLine guibg=darkgrey guifg=white
" au! Cursorhold * exe 'match CurrentLine /\%' . line('.') . 'l.*/'
" set ut=100
"set cursorcolumn
set cursorline
set gcr=a:block-blinkon0

" change the terminal's title
set title

" 禁用错误提示
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" 显示行号
set number

" 打开状态栏标尺
set ruler

" 显示用户当前的操作
set showcmd

" 高亮搜索内容
set hls

" 运行宏时不重绘屏幕
set lz

" fixed
set scrolloff=3
set shortmess=atI
" gui-win32-maximized
"au GUIEnter * simalt ~x
set columns=90
set lines=30

" 关闭鼠标
set mouse-=a

" 不用alt键访问菜单
set winaltkeys=no

" 禁用断行
set nolinebreak

" 对不明宽度字符的处理方式
set ambiwidth=double

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" NOTE: this setting will change text source
set textwidth=80
set fo+=m
set clipboard+=unnamed

" F11 maximize window
"if has("gui_running") && has("win32")
"    map <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
"endif

" Search
set incsearch
set ignorecase
" ignore case if search pattern is all lowercase, case-sensitive otherwise
set smartcase

vnoremap  *  y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>
vnoremap  #  y?<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>

set foldenable
set foldmethod=syntax
set foldmethod=indent
set foldlevel=6
set foldcolumn=0

" Tabs
set softtabstop=4
" replace tab to whitespace
set expandtab
" show tab indent word space
set tabstop=4
" tab length
set shiftwidth=4
" break full word
set linebreak
" new line indent same this line
set autoindent
" Smart indent
set smartindent
"set splitright
"set splitbelow

" file encode
" 设置vim内部编码
set encoding=utf-8
set termencoding=utf-8
set helplang=cn
"language message zh_CN.UTF-8
"set langmenu=zh_CN.UTF-8
"set enc=2byte-gb18030
"
" 设置文件编码
set fileencoding=utf-8

" 设置文件编码集 :help encoding-values
"set fileencodings=ucs-bom,utf-8,chinese,gbk,gb18030,taiwan,japan,korea,latin-1
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set formatoptions+=m
set formatoptions+=B

" ffs=dos,unix
set fileformat=unix
set fileformats=dos,unix,mac

if has("persistent_undo")
    set undofile
    set undolevels=1000

    if g:OS#win
        set undodir=$VIM\undodir
        au BufWritePre undodir/* setlocal noundofile
    else
        set undodir=~/.undodir
        au BufWritePre ~/.undodir/* setlocal noundofile
    endif
endif

" @see http://liyanrui.is-programmer.com/articles/1791/gvim-menu-and-toolbar-toggle.html
if g:OS#gui
" 去掉菜单栏
    set guioptions-=m
" 去掉工具栏
    set guioptions-=T
" 去掉右侧滚动条
    set guioptions-=r
    set guioptions-=L
    map <silent> <F2> :if &guioptions =~# 'T' <Bar>
            \set guioptions-=T <Bar>
            \set guioptions-=m <bar>
        \else <Bar>
            \set guioptions+=T <Bar>
            \set guioptions+=m <Bar>
        \endif<CR>
endif

if g:OS#gui
    set autochdir
    set colorcolumn=81
    hi colorcolumn guibg=#444444
    "syn match out80 /\%80v./ containedin=ALL
    "hi out80 guifg=#333333 guibg=#ffffff
endif

" Vimrc Auto
"autocmd! bufwritepost _vimrc source %
autocmd! bufwritepost .vimrc source %

"if g:OS#win
"    hi cursorline gui=underline guibg=NONE cterm=underline
"endif

" Show tab number in your tab line
" @see http://vim.wikia.com/wiki/Show_tab_number_in_your_tab_line
" :h tabline
"if g:OS#gui
    " TODO: for MacVim.
    "set guitablabel=%N.%t
"endif

" 设置状态栏显示方式
set laststatus=2
" 设置状态栏显示内容
set statusline=%t\ %1*%m%*\ %1*%r%*\ %2*%h%*%w%=%l%3*/%L(%p%%)%*,%c%V]\ [%b:0x%B]\ [%{&ft==''?'TEXT':toupper(&ft)},%{toupper(&ff)},%{toupper(&fenc!=''?&fenc:&enc)}%{&bomb?',BOM':''}%{&eol?'':',NOEOL'}]
hi User1 guibg=red guifg=yellow
hi User2 guibg=#008000 guifg=white
hi User3 guibg=#C2BFA5 guifg=#999999

"set statusline+= %{FileTime()}

"fu! FileTime()
"let ext=tolower(expand("%:e"))
"let fname=tolower(expand('%<'))
"let filename=fname . '.' . ext
"let msg=""
"let msg=msg." ".strftime("(Modified %b,%d %y %H:%M:%S)",getftime(filename))
"return msg
"endf

"fu! CurTime()
"let ftime=""
"let ftime=ftime." ".strftime("%b,%d %y %H:%M:%S")
"return ftime
"endf

" ------------------------------- Mappings ------------------------------ {{{
" Normal Mode, Visual Mode, and Select Mode,
" use <Tab> and <Shift-Tab> to indent
" @see http://c9s.blogspot.com/2007/10/vim-tips.html
"nmap <tab> v>                  " :h ctrl-i :h <tab>
"nmap <s-tab> v<
vmap <tab> >gv
vmap <s-tab> <gv

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

" 删除^M
nmap <leader>dm mmHmn:%s/<C-V><CR>//ge<CR>'nzt'm

" Remove trailing whitespace when writing a buffer, but not for diff files.
autocmd BufWritePre * :%s/\s\+$//e
autocmd BufWritePre * %s/^$\n\+\%$//ge
au BufWritePre * exe 'sil! 1,' . min([line('$'), 20]) . 's/^\S\+\s\+Last modified: \zs.*/\=strftime("%y-%m-%d %H:%M:%S")/e'
