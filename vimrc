set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
 set rtp+=~/.vim/bundle/Vundle.vim
 call vundle#begin()
" " alternatively, pass a path where Vundle should install plugins
" "call vundle#begin('~/some/path/here')
"
" " let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Bundle 'chase/vim-ansible-yaml'
Bundle 'scrooloose/nerdtree'
Bundle 'klen/python-mode'




call vundle#end()            " required
filetype plugin indent on    " required
syntax on

let mapleader=","
let g:ansible_options = {'ignore_blank_lines': 0}
color jellybeans


"set mouse=a
set number
set ts=4
set autoindent
set expandtab
set showmatch
let python_highlight_all = 1


"hidding highligt of looking text
noremap <C-n> :nohl<CR>
vnoremap <C-n> :nohl<CR>
inoremap <C-n> :nohl<CR>

"quick save
noremap <C-Z> :update<CR>
vnoremap <C-Z> <C-C>:update<CR>
inoremap <C-Z> <C-O>:update<CR>



" NERDTree
nmap <leader>n :NERDTreeToggle<CR>
let NERDTreeHighlightCursorline=1
let NERDTreeIgnore = ['tmp', '.yardoc', 'pkg']
