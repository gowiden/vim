" Author:  Todd <https://about.me/vimer>
" Last_modify: 2015-10-26
" Desc: simple vim config, without any plugins.

" leader
let mapleader = ','
let g:mapleader = ','

" syntax
syntax on

" history : how many lines of history VIM has to remember
set history=500

" filetype
filetype on
" Enable filetype plugins
filetype plugin on
filetype indent on

" base
set nocompatible       " don't bother with vi compatibility
set autoread           " reload files when changed on disk, i.e. via `git checkout`
set shortmess=atI
set cm=blowfish
set magic              " For regular expressions turn magic on
set title              " change the terminal's title
set nobackup           " do not keep a backup file
set noswapfile

set novisualbell       " turn off visual bell
set noerrorbells       " don't beep
"set visualbell t_vb=   " turn off error beep/flash
set t_vb=
set tm=500

" show location
"set cursorcolumn
set cursorline

" movement
set scrolloff=3        " keep 3 lines when scrolling

"au GUIEnter * simalt ~x
set lines=30 columns=90

" show
set ruler              " show the current row and column
set number             " show line numbers
set wrap
set showcmd            " display incomplete commands
set showmode           " display current modes
set showmatch          " jump to matches when entering parentheses
set matchtime=2        " tenths of a second to show the matching parenthesis
set nolinebreak
set ambiwidth=double

" search
set hlsearch           " highlight searches
set incsearch          " do incremental searching, search as you type
set ignorecase         " ignore case when searching
set smartcase          " no ignorecase if Uppercase char present

" tab
set expandtab          " expand tabs to spaces
set smarttab
set shiftround
set linebreak          " break full word
"set splitright
"set splitbelow

" indent
set autoindent smartindent shiftround
set shiftwidth=4
set tabstop=4
set softtabstop=4      " insert mode tab and backspace use 4 spaces

" NOT SUPPORT
" fold
set foldenable
set foldmethod=syntax
set foldmethod=indent
set foldlevel=99
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

" font
set guifont=Bitstream\ Vera\ Sans\ Mono\ 11
"set guifont=Fixedsys:h12:cGB2312

" encoding
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set termencoding=utf-8
set ffs=unix,dos,mac
set formatoptions+=m
set formatoptions+=B

" select & complete
set selection=inclusive
set selectmode=mouse,key

set completeopt=longest,menu
set wildmenu                    " show a navigable menu for tab completion"
set wildmode=longest,list,full
set wildignore=*.o,*~,*.pyc,*.class

" others
set backspace=indent,eol,start  " make that backspace key work the way it should
set whichwrap+=<,>,h,l

" if this not work ,make sure .viminfo is writable for you
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" NOT SUPPORT
" Enable basic mouse behavior such as resizing buffers.
set mouse=a

" ============================ theme and status line ============================

" theme
set background=dark

colorscheme desert

"Toggle Menu and Toolbar
"@see http://liyanrui.is-programmer.com/articles/1791/gvim-menu-and-toolbar-toggle.html
set guioptions-=m
set guioptions-=T
map <silent> <F2> :if &guioptions =~# 'T' <Bar>
        \set guioptions-=T <Bar>
        \set guioptions-=m <bar>
    \else <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=m <Bar>
    \endif<CR>

set autochdir
set colorcolumn=81
hi colorcolumn guibg=#444444

" set mark column color
hi! link SignColumn   LineNr
hi! link ShowMarksHLl DiffAdd
hi! link ShowMarksHLu DiffChange

" status line
set statusline=%t\ %1*%m%*\ %1*%r%*\ %2*%h%*%w%=%l%3*/%L(%p%%)%*,%c%V]\ [%b:0x%B]\ [%{&ft==''?'TEXT':toupper(&ft)},%{toupper(&ff)},%{toupper(&fenc!=''?&fenc:&enc)}%{&bomb?',BOM':''}%{&eol?'':',NOEOL'}]
hi User1 guibg=red guifg=yellow
hi User2 guibg=#008000 guifg=white
hi User3 guibg=#C2BFA5 guifg=#999999

set laststatus=2   " Always show the status line - use 2 lines for the status bar

" del ^M
nmap <leader>dm mmHmn:%s/<C-V><CR>//ge<CR>'nzt'm

" ============================ specific file type ===========================

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

" ============================ key map ============================
" Normal Mode, Visual Mode, and Select Mode,
" use <Tab> and <Shift-Tab> to indent
" @see http://c9s.blogspot.com/2007/10/vim-tips.html
"nmap <tab> v>                  " :h ctrl-i :h <tab>
"nmap <s-tab> v<
vmap <tab> >gv
vmap <s-tab> <gv

nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j

map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

map <C-kPlus> <C-w>+
map <C-kMinus> <C-w>-
map <C-S-kPlus> <C-w>_
map <C-S-kMinus> <C-w>_

map <C-c> "+y
map <C-v> "+p

"nnoremap <F2> :set nu! nu?<CR>
"nnoremap <F3> :set list! list?<CR>
"nnoremap <F4> :set wrap! wrap?<CR>
"set pastetoggle=<F5>            "    when in insert mode, press <F5> to go to
                                "    paste mode, where you can paste mass data
                                "    that won't be autoindented
"au InsertLeave * set nopaste
"nnoremap <F6> :exec exists('syntax_on') ? 'syn off' : 'syn on'<CR>

" kj => Esc
"inoremap kj <Esc>

" Quickly close the current window
nnoremap <leader>q :q<CR>
" Quickly save the current file
nnoremap <leader>w :w<CR>

" select all
map <Leader>sa ggVG"

" remap U to <C-r> for easier redo
nnoremap U <C-r>

" Swap implementations of ` and ' jump to markers
" By default, ' jumps to the marked line, ` jumps to the marked line and
" column, so swap them
nnoremap ' `
nnoremap ` '

" switch # *
" nnoremap # *
" nnoremap * #

"Keep search pattern at the center of the screen."
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" remove highlight
noremap <silent><leader>/ :nohls<CR>

"Reselect visual block after indent/outdent.
vnoremap < <gv
vnoremap > >gv

" y$ -> Y Make Y behave like other capitals
map Y y$

"Map ; to : and save a million keystrokes
" ex mode commands made easy
nnoremap ; :

" save
cmap w!! w !sudo tee >/dev/null %

" command mode, ctrl-a to head， ctrl-e to tail
cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
