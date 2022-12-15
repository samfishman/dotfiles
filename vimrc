set nocompatible
filetype off

" VUNDLE PLUGINS
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-sensible'
Plugin 'chriskempson/base16-vim'
Plugin 'kana/vim-arpeggio'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'ervandew/supertab'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-sleuth'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-abolish'  " Fuzzy autocorrect
Plugin 'tpope/vim-markdown'
Plugin 'a.vim' " switching to last file
Plugin 'LaTeX-Box-Team/LaTeX-Box'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'crusoexia/vim-monokai'

" Plugin 'tpope/vim-repeat'
" Plugin 'mattn/emmet-vim'
" Plugin 'carlhuda/janus'
" Plugin 'Raimondi/delimitMate'
" Plugin 'davidhalter/jedi-vim'
" Plugin 'yssl/QFEnter'
" Plugin 'ryanss/vim-hackernews'
Plugin 'fatih/vim-go'
Plugin 'kchmck/vim-coffee-script'
Plugin 'digitaltoad/vim-jade'
" Plugin 'scrooloose/syntastic'
Plugin 'solarnz/thrift.vim'
" Plugin 'guns/vim-clojure-static'
" Plugin 'kien/rainbow_parentheses.vim'
Plugin 'leafgarland/typescript-vim'

call vundle#end()

filetype plugin indent on
syntax on

set background=dark
" colorscheme base16-monokai
colorscheme monokai

" OCaml Merlin Setup
let g:has_opam = 0
let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
if v:shell_error == "0"
    let g:has_opam = 1
    execute "set rtp+=" . g:opamshare . "/merlin/vim"
    execute "set rtp+=" . g:opamshare . "/ocp-indent/vim"
endif

" REMAPS
let mapleader=','
let maplocalleader = ",,"
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

function! s:WorkonProj(name)
    for dir in split($CODE_PATH, ":")
        let path = dir . "/" . a:name
        if isdirectory(path)
            cd `=path`
            e .
            return
        endif
    endfor
    echom "Project " . a:name . " not found."
endfunction
function! ListProjects(A,L,P)
    return system("find $CODE ! -path $CODE -maxdepth 1 -type d -exec basename {} \\;")
endfunction
command! -complete=custom,ListProjects -nargs=1 Wk :call <SID>WorkonProj(<q-args>)

function! s:ToggleNums()
    if &l:number
        set nonumber
    elseif &l:relativenumber
        set norelativenumber
    else
        set number
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
set relativenumber
set colorcolumn=+1
set history=1000
set undolevels=1000
set wildignore=*.cmi,*.cmo,*.mid,*.pyo,*.pyc,*.ctxt,*.jar,*.jpg,*.jpeg,*.png,*.swp
set wildignore+=*.gif,*.tiff,*.o
set formatoptions+=n  " list reformatting
set formatlistpat=^\\s*\\(\\d\\+\\\\|-\\+>\\?\\\\|[a-zA-Z]\\.\\)[\\]:.)}\\t\ ]\\s*  " list reformatting
match ErrorMsg /\%>80v.\+/
set backupcopy=yes

" used by whitespace plugin
highlight ExtraWhitespace ctermbg=1 guibg=#f92672

" PLUGIN SETTINGS
nmap <Leader>f <Plug>(easymotion-f)
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
let g:ctrlp_custom_ignore='node_modules\|\\.git'
let g:ctrlp_root_markers = ['METADATA']
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = '/usr/bin/ag %s -i --nocolor --nogroup --hidden
    \ --ignore .git
    \ --ignore ".*.sw[pno]"
    \ --ignore .svn
    \ --ignore .hg
    \ --ignore .DS_Store
    \ --ignore "**/*.pyc"
    \ --ignore .git5_specs
    \ --ignore review
    \ -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" AUTOCMDS
if has("autocmd")
    augroup primary
        " Clear all autocommands
        au!

        au InsertEnter * set number
        au InsertLeave * set relativenumber

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

        au FileType tex inoremap <buffer> <leader>m _{}<left>
        au FileType tex inoremap <buffer> <leader>l ^{}<left>
        au FileType tex nnoremap <buffer> <Leader>ll :w<CR>:Latexmk<CR>
        au FileType tex nnoremap <buffer> <Leader>lv :LatexView<CR>
        au FileType tex setlocal wrap

        if g:has_opam
            au FileType ocaml call SuperTabSetDefaultCompletionType("<c-x><c-o>")
            au FileType ocaml nmap <buffer><silent> <LocalLeader>c :MerlinClearEnclosing<CR>
        endif
        
        au FileType ocaml setlocal commentstring=(*\ %s\ *)

        " au VimEnter * RainbowParenthesesActivate
        " au FileType clojure RainbowParenthesesLoadRound

        au BufNewFile,BufRead *.zsh-theme setf zsh

        " Hack to get textwidth to only go into effect if filetype-specific
        " textwidth isn't defined. This runs after filetype plugins are run.
        au FileType * if (&tw == 0) | setlocal tw=79 | endif

        " Re-source vimrc on save
        " au BufWritePost .vimrc,vimrc nested so $MYVIMRC

        au QuickFixCmdPost *grep* cwindow

        " <S-CR> is mapped to ✠ (U+2720) on my iTerm2
        au BufNewFile,BufRead * if (&buftype isnot# 'quickfix') | nnoremap <buffer> ✠ O<Esc>| endif
        au BufNewFile,BufRead * if (&buftype isnot# 'quickfix') | nnoremap <buffer> <CR> o<Esc>| endif
    augroup END
endif

