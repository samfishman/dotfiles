set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-sensible'
Plugin 'chriskempson/base16-vim'
Plugin 'kana/vim-arpeggio'
Plugin 'tpope/vim-fugitive'
Plugin 'bling/vim-airline'
Plugin 'kien/ctrlp.vim'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'mattn/emmet-vim'
Plugin 'carlhuda/janus'
Plugin 'ervandew/supertab'
Plugin 'Raimondi/delimitMate'
Plugin 'tpope/vim-surround'
Plugin 'davidhalter/jedi-vim'
Plugin 'tpope/vim-coffee-script'
Plugin 'tpope/vim-sleuth'
Plugin 'scrooloose/nerdcommenter'

call vundle#end()
filetype plugin indent on

set background=dark
colorscheme base16-monokai

" REMAPS
let mapleader=','
nnoremap <silent> <CR> :w<CR>
nnoremap ; :
nnoremap <silent> Z :x<CR>
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
vnoremap Q gq
nnoremap Q gqap
call arpeggio#map('n', '', 0, 'jk', ':CtrlP<CR>')
set pastetoggle=<Leader>p
call arpeggio#map('n', '', 0, 'fd', ':nohlsearch<CR>')

function ToggleNums()
    if &l:nu
        set nonu
    else
        set nu
    endif
endfunction
nnoremap <silent> <Leader>c :call ToggleNums()<CR>

" SETTINGS
set nu
set nowrap
set tabstop=4
set shiftwidth=4
set smarttab
set autoindent
set copyindent
set showmatch
set smartcase
set ignorecase
set hlsearch
set incsearch
set hidden
set history=1000
set undolevels=1000
set wildignore=*.cmi,*.cmo,*.mid,*.pyo,*.pyc,*.ctxt,*.jar,*.jpg,*.jpeg,*.png,*.swp
set wildignore+=*.gif,*.tiff,*.o,*/data/*

" PLUGIN SETTINGS
let g:airline_powerline_fonts=1

map <Leader><Leader> <Plug>(easymotion-prefix)
nmap <Leader>t <Plug>(easymotion-t)
nmap <Leader>f <Plug>(easymotion-f)
nmap <Leader>T <Plug>(easymotion-T)
nmap <Leader>F <Plug>(easymotion-F)
nmap <Leader>j <Plug>(easymotion-j)
nmap <Leader>k <Plug>(easymotion-k)

let NERDCreateDefaultMappings=0
nmap gcc <Plug>NERDCommenterToggle

" FILE SPECIFC
if has("autocmd")
    au BufRead,BufNewFile *.jinja2 set filetype=html
endif

