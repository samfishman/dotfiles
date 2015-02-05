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
Plugin 'a.vim'
Plugin 'LaTeX-Box-Team/LaTeX-Box'

call vundle#end()

filetype plugin indent on
syntax on

set background=dark
colorscheme base16-monokai

" REMAPS
let mapleader=','
let maplocalleader = "\\"
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
nnoremap yp :let @" = expand("%")<CR>:echo "yanked filepath"<CR>
call arpeggio#map('n', 's', 0, 'jk', ':CtrlP<CR>')
set pastetoggle=<Leader>p
call arpeggio#map('n', 's', 0, 'fd', ':nohlsearch<CR>')
call arpeggio#map('n', 's', 0, 'we', ':A<CR>')
call arpeggio#map('n', 's', 0, 'qw', ':AS<CR>')
call arpeggio#map('n', '', 0, 'io', '<C-^>')
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
set formatlistpat=^\\s*\\(\\d\\+\\\\|-\\+>\\?\\\\|[a-zA-Z]\\.\\)[\\]:.)}\\t\ ]\\s*  " list reformatting


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

let g:LatexBox_viewer="open -a Skim.app"
let g:LatexBox_no_mappings=1
let g:LatexBox_quickfix=4

" AUTOCMDS
if has("autocmd")
    augroup primary
        " Clear all autocommands
        au!

        " Specific filetypes
        au BufNewFile,BufRead *.jinja2 setlocal filetype=html

        au BufNewFile,BufRead bashrc*,aliases* call SetFileTypeSH("bash")
        au BufNewFile,BufRead bashrc*,aliases* setlocal syntax=sh

        au BufNewFile,BufRead *.txt setlocal tw=79
        au BufNewFile,BufRead *.txt setlocal formatoptions+=t
        au BufNewFile,BufRead *.txt setlocal tabstop=2
        au BufNewFile,BufRead *.txt setlocal shiftwidth=2
        au BufNewFile,BufRead *.txt setlocal wrap

        au FileType latex inoremap <leader>m _{}<left>
        au FileType latex inoremap <leader>l ^{}<left>
        au FileType latex nnoremap <Leader>ll :w<CR>:Latexmk<CR>
        au FileType latex nnoremap <Leader>lv :LatexView<CR>

        " Re-source vimrc on save
        au BufWritePost .vimrc,vimrc nested so $MYVIMRC

        au QuickFixCmdPost *grep* cwindow
    augroup END
endif

