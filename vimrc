set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-sensible'
Plugin 'chriskempson/base16-vim'
Plugin 'kana/vim-arpeggio'
Plugin 'tpope/vim-fugitive'
Plugin 'powerline/powerline', {'rtp': 'powerline/bindings/vim'}
Plugin 'kien/ctrlp.vim'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'mattn/emmet-vim'
"Plugin 'carlhuda/janus'
Plugin 'ervandew/supertab'
Plugin 'Raimondi/delimitMate'
Plugin 'tpope/vim-surround'
Plugin 'davidhalter/jedi-vim'
Plugin 'tpope/vim-coffee-script'
Plugin 'tpope/vim-sleuth'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-abolish'  " Fuzzy autocorrect
Plugin 'yssl/QFEnter'

call vundle#end()
filetype plugin indent on

set background=dark
colorscheme base16-monokai

" REMAPS
let mapleader=','
nnoremap <silent> Z :w<CR>
nnoremap <silent> X :x<CR>
nnoremap ; :
vnoremap ; :
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
vnoremap Q gq
nnoremap Q gqap
call arpeggio#map('n', 's', 0, 'jk', ':CtrlP<CR>')
set pastetoggle=<Leader>p
call arpeggio#map('n', 's', 0, 'fd', ':nohlsearch<CR>')
" Keep visual block selected
vnoremap < <gv
vnoremap > >gv

function! s:ToggleNums()
    if &l:nu
        set nonu
    else
        set nu
    endif
endfunction
" <SID> is the same as s: but works when called outside of this script
nnoremap <silent> <Leader>c :call <SID>ToggleNums()<CR>

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
set title
set history=1000
set undolevels=1000
set wildignore=*.cmi,*.cmo,*.mid,*.pyo,*.pyc,*.ctxt,*.jar,*.jpg,*.jpeg,*.png,*.swp
set wildignore+=*.gif,*.tiff,*.o
set formatoptions+=n  " list reformatting
set formatlistpat=^\\s*\\(\\d\\|-\\)\\+[\\]:.)}\\t\ ]\\s*  " list reformatting

" PLUGIN SETTINGS
map <Leader><Leader> <Plug>(easymotion-prefix)
nmap <Leader>t <Plug>(easymotion-t)
nmap <Leader>f <Plug>(easymotion-f)
nmap <Leader>T <Plug>(easymotion-T)
nmap <Leader>F <Plug>(easymotion-F)
nmap <Leader>j <Plug>(easymotion-j)
nmap <Leader>k <Plug>(easymotion-k)

hi link EasyMotionTarget ErrorMsg
hi link EasyMotionShade  Comment
hi link EasyMotionTarget2First ErrorMsg
hi link EasyMotionTarget2Second ErrorMsg

" AUTOCMDS
if has("autocmd")
    " Clear all autocommands
    au!

    " Specific filetypes
    au BufNewFile,BufRead *.jinja2 set filetype=html
    au BufNewFile,BufRead bashrc*,aliases* call SetFileTypeSH("bash")
    au BufNewFile,BufRead bashrc*,aliases* set syntax=sh

    " Re-source vimrc on save
    au BufWritePost .vimrc,vimrc nested so $MYVIMRC

    au QuickFixCmdPost *grep* cwindow
endif

