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
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'ryanss/vim-hackernews'
Plugin 'fatih/vim-go'

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
call arpeggio#map('n', 's', 0, 'kl', ':CtrlPTag<CR>')
set pastetoggle=<Leader>p
call arpeggio#map('n', 's', 0, 'fd', ':nohlsearch<CR>')
call arpeggio#map('n', 's', 0, 'we', ':A<CR>')
call arpeggio#map('n', 's', 0, 'qw', ':AS<CR>')
call arpeggio#map('n', '', 0, 'io', '<C-^>')
nnoremap Y y$
" Keep visual block selected
vnoremap < <gv
vnoremap > >gv
nnoremap <silent> <C-n> :bn<CR>
nnoremap <silent> <C-p> :bp<CR>

" Restore scroll on buffer change.
" Credit: http://stackoverflow.com/questions/4251533/vim-keep-window-position-when-switching-buffers
if v:version >= 700
    au BufLeave * let b:winview = winsaveview()
    au BufEnter * if(exists('b:winview')) | call winrestview(b:winview) | endif
endif

command! Twrap setlocal formatoptions+=t | setlocal wrap

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
set expandtab
set autoindent
set copyindent
set showmatch
set smartcase
set ignorecase
set hlsearch
set incsearch
set hidden
set title
set colorcolumn=+1
set history=1000
set undolevels=1000
set wildignore=*.cmi,*.cmo,*.mid,*.pyo,*.pyc,*.ctxt,*.jar,*.jpg,*.jpeg,*.png,*.swp
set wildignore+=*.gif,*.tiff,*.o
set formatoptions+=n  " list reformatting
set formatlistpat=^\\s*\\(\\d\\+\\\\|-\\+>\\?\\\\|[a-zA-Z]\\.\\)[\\]:.)}\\t\ ]\\s*  " list reformatting
match ErrorMsg /\%>80v.\+/

" used by whitespace plugin
highlight ExtraWhitespace ctermbg=1 guibg=#f92672

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

let g:jedi#popup_on_dot = 0

let g:ctrlp_map = ''

" AUTOCMDS
if has("autocmd")
    augroup primary
        " Clear all autocommands
        au!

        " Specific filetypes
        au BufNewFile,BufRead *.jinja2 setlocal filetype=html

        au BufNewFile,BufRead bashrc*,aliases* call SetFileTypeSH("bash")
        au BufNewFile,BufRead bashrc*,aliases* setlocal syntax=sh

        au BufNewFile,BufRead *.txt setf text
        au FileType text setlocal tw=79
        au FileType text setlocal formatoptions+=t
        au FileType text setlocal tabstop=2
        au FileType text setlocal shiftwidth=2
        au FileType text setlocal wrap

        au FileType tex inoremap <leader>m _{}<left>
        au FileType tex inoremap <leader>l ^{}<left>
        au FileType tex nnoremap <Leader>ll :w<CR>:Latexmk<CR>
        au FileType tex nnoremap <Leader>lv :LatexView<CR>
        au FileType tex setlocal wrap

        au BufNewFile,BufRead *.zsh-theme setf zsh

        " Hack to get textwidth to only go into effect if filetype-specific
        " textwidth isn't defined. This runs after filetype plugins are run.
        au FileType * if (&tw == 0) | setlocal tw=79 | endif

        " Re-source vimrc on save
        au BufWritePost .vimrc,vimrc nested so $MYVIMRC

        au QuickFixCmdPost *grep* cwindow
    augroup END
endif

