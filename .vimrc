" Vundle setup
set nocompatible
filetype on
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

if $TERM == "xterm-256color"
    set t_Co=256
endif
" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
    au BufRead,BufNewFile *.jinja2 set filetype=html
    au BufRead,BufNewFile *.jinja2 nnoremap <leader>s :w<CR>:!compile_jinja2<CR>
    au BufRead,BufNewFile *.pde set filetype=c
    au BufRead,BufNewFile *.c.txt set filetype=c
    au BufRead,BufNewFile *.tex nnoremap <leader>s :w<CR>:!tex_to_pdf<CR><CR>
"  filetype plugin indent on
endif

" map ,v :w<CR>:silent !/Applications/Skim.app/Contents/SharedSupport/displayline -r <C-r>=line('.')<CR> %<.pdf %<CR><CR>
" map ,p :w<CR>:silent !pdflatex -synctex=1 --interaction=nonstopmode %:p <CR>:silent !/Applications/Skim.app/Contents/SharedSupport/displayline -r <C-r>=line('.')<CR> %<.pdf %<CR><CR>
" map ,m :w<CR>:silent !make <CR>:silent !/Applications/Skim.app/Contents/SharedSupport/displayline -r <C-r>=line('.')<CR> %<.pdf %<CR><CR>
" " Reactivate VIM
" map ,r :w<CR>:silent !/Applications/Skim.app/Contents/SharedSupport/displayline -r <C-r>=line('.')<CR> %<.pdf %<CR>:silent !osascript -e "tell application \"MacVim\" to activate" <CR><CR>
" map ,t :w<CR>:silent !pdflatex -synctex=1 --interaction=nonstopmode %:p <CR>:silent !/Applications/Skim.app/Contents/SharedSupport/displayline -r <C-r>=line('.')<CR> %<.pdf %<CR>:silent !osascript -e "tell application \"MacVim\" to activate" <CR><CR>
"
function! MarkWindowSwap()
    let g:markedWinNum = winnr()
endfunction

function! DoWindowSwap()
    "Mark destination
    let curNum = winnr()
    let curBuf = bufnr( "%" )
    exe g:markedWinNum . "wincmd w"
    "Switch to source and shuffle dest->source
    let markedBuf = bufnr( "%" )
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' curBuf
    "Switch to dest and shuffle source->dest
    exe curNum . "wincmd w"
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' markedBuf 
endfunction

if &term=~"^xterm"
    let &t_SI .= "\<Esc>]50;CursorShape=1\x7"
    let &t_EI .= "\<Esc>]50;CursorShape=0\x7"
endif


set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase      " Do smart case matching
set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
set hidden             " Hide buffers when they are abandoned
set backspace=indent,eol,start

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

let mapleader=","
nnoremap ; :

nnoremap <leader><leader> $
nnoremap <leader>wl <c-w>l 
nnoremap <leader>wh <c-w>h 
nnoremap <leader>wj <c-w>j 
nnoremap <leader>wk <c-w>k 
" nnoremap <leader>
inoremap <leader>n <c-n>
nnoremap <silent> <leader>mw :call MarkWindowSwap()<CR>
nnoremap <silent> <leader>pw :call DoWindowSwap()<CR>
inoremap jj <Esc>
" Automatically close opening brackets
" inoremap {      {}<Left>
" inoremap {<CR>  {<CR>}<Esc>O
" inoremap {{     {
" inoremap {}     {}
" inoremap (      ()<Left>
" inoremap (<CR>  (<CR>)<Esc>O
" inoremap ((     (
" inoremap ()     ()
" inoremap [      []<Left>
" inoremap [<CR>  [<CR>]<Esc>O
" inoremap [[     [
" inoremap []     []
" inoremap '      ''<Left>
" inoremap ''     ''
" inoremap "      ""<Left>
" inoremap ""     ""
syntax on
set expandtab
set shiftwidth=4
set tabstop=4
set autoindent
set copyindent
set number
" (un)indent to nearest tabstop
set shiftround
set mouse=a
set history=1000
set undolevels=1000
set wildignore=*.cmi,*.cmo,*.mid,*.pyo,*.pyc,*.ctxt,*.jar,*.jpg,*.jpeg,*.png
set wildignore+=*.gif,*.tiff,*.o,*/data/*
set title
set visualbell
set noerrorbells
set nobackup
set pastetoggle=<F2>
" colored column at 81 chars
set colorcolumn=81
set laststatus=2

" ESC doesn't make cursor move back
" let CursorColumnI = 0 "the cursor column position in INSERT
" autocmd InsertEnter * let CursorColumnI = col('.')
" autocmd CursorMovedI * let CursorColumnI = col('.')
" autocmd InsertLeave * if col('.') != CursorColumnI | call cursor(0, col('.')+1) | endif

" Highlight characters over the 80 char limit
" match ErrorMsg '\%>80v.\+'
set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
let g:ctrlp_map = '<leader>t'
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>'],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
    \ }
let g:ctrlp_cmd = 'CtrlPMixed'
let g:user_zen_expandabbr_key = '<leader>f'
" Bundles
Bundle 'gmarik/vundle'
" Colorschemes
Bundle 'flazz/vim-colorschemes'
Bundle 'altercation/vim-colors-solarized'
Bundle 'vim-scripts/xoria256.vim'
Bundle 'vim-scripts/mayansmoke'
Bundle 'tomasr/molokai'
Bundle 'chriskempson/vim-tomorrow-theme'
Bundle 'thinca/vim-guicolorscheme'
" Bundle 'wincent/Command-T'
Bundle "kien/ctrlp.vim"
Bundle 'nvie/vim-togglemouse'
Bundle 'tomtom/tcomment_vim'
" Bundle 'Yggdroot/indentLine'
Bundle 'cakebaker/scss-syntax.vim'
" Bundle 'mitsuhiko/jinja2'
" Bundle 'vim-scripts/AutoComplPop'
Bundle 'mattn/zencoding-vim'
" Auto close parens
Bundle 'Raimondi/delimitMate'
Bundle 'tpope/vim-surround'
Bundle 'othree/html5.vim'
Bundle 'octol/vim-cpp-enhanced-highlight'
" Tab to autocomplete
" Bundle 'ervandew/supertab'
Bundle 'Lokaltog/powerline'

filetype plugin indent on

nmap <S-Enter> O<Esc>j
nmap <CR> o<Esc>k

