set nocompatible

" VIM FILES
set dir=~/.vim/
set bdir=~/.vim/
set viminfo+=n~/.vim/.viminfo

" UI
set number
set relativenumber
set wildmenu
set showcmd
set shortmess=a

" SEARCH
set incsearch
set hlsearch
set ignorecase
set smartcase

" EDITOR
syntax on
set backspace=indent,eol,start
set autoindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" REMAPS
nnoremap j gj
nnoremap k gk

" PLUGINS
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin()
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'
    Plug 'morhetz/gruvbox'
call plug#end()
" gruvbox
colorscheme gruvbox
set background=dark
