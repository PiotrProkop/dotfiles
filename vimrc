set nocompatible              " be iMproved, required
set nobackup                  " Don't keep backup file
set clipboard=unnamed        " Yank and paste with the system clipboard

filetype off                  " required


call plug#begin('~/.vim/bundle')
Plug 'Rykka/riv.vim', { 'for': 'rst' }
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'fatih/vim-go'
Plug 'majutsushi/tagbar'
Plug 'morhetz/gruvbox'
Plug 'junegunn/goyo.vim'
Plug 'elixir-lang/vim-elixir'
Plug 'Konfekt/FastFold'
Plug 'tpope/vim-fugitive'
Plug 'ervandew/supertab'
 "Plug 'klen/python-mode'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jlanzarotta/bufexplorer'
Plug 'scrooloose/syntastic'
Plug 'christoomey/vim-tmux-navigator'
 "Plug 'Valloric/YouCompleteMe'
Plug 'racer-rust/vim-racer'
Plug 'rust-lang/rust.vim'
Plug 'fs111/pydoc.vim', { 'for': 'python' }
Plug 'mduan/python.vim', { 'for': 'python' }
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
Plug 'gryf/pep8-vim', { 'for': 'python' }
Plug 'gryf/pylint-vim', { 'for': 'python' }
Plug 'gryf/python-syntax', { 'for': 'python' }
Plug 'vim-scripts/indentpython', { 'for': 'python' }
Plug 'tpope/vim-commentary'
Plug 'yuttie/comfortable-motion.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'stephpy/vim-yaml'
Plug 'elzr/vim-json'
call plug#end()            " required

filetype plugin indent on    " required

syntax on
"change mapleader
let mapleader=","

let g:ansible_options = {'ignore_blank_lines': 0}

if has('gui_running')
    set background=light
else
    set background=dark
endif

"Supertab
let g:SuperTabDefaultCompletionType = "<c-n>"

color gruvbox
" Gruvbox colorscheme
let g:gruvbox_contrast_dark = "hard"
let g:gruvbox_contrast_light = "soft"
"color gruvbox
"
"Highlight active column and line 
set cursorline
set cursorcolumn

""settings fo golnang
let g:acp_enableAtStartup = 0
"Use neocomplete.
let g:neocomplete#enable_at_startup = 1
"Use smartcase.
let g:neocomplete#enable_smart_case = 1
"Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
  
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
    return neocomplete#close_popup() . "\<CR>"
endfunction

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()

" Go related mappings
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>r <Plug>(go-run)
au FileType go nmap <Leader>b <Plug>(go-build)
au FileType go nmap <Leader>t <Plug>(go-test)
"au FileType go nmap gd <Plug>(go-def-tab)
au FileType go nmap <Leader>e <Plug>(go-rename)

"Golang highligt 
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 0
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"

"Golang settings
let g:go_metalinter_enabled = ['vet', 'errcheck']
let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ['vet']
let g:go_metalinter_deadline = "5s"
"let g:go_auto_type_info = 1
"let g:go_auto_sameids = 1
set updatetime=100

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

" TagBar
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

nmap <F8> :TagbarToggle<CR>

" NERDTree
"autocmd VimEnter * NERDTree
"autocmd VimEnter * wincmd p
nmap <leader>m :NERDTreeToggle<CR>
let NERDTreeHighlightCursorline=1
let NERDTreeIgnore = ['tmp', '.yardoc']
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"sudo save
cmap w!! w !sudo tee % >/dev/null

"Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

"Learn to use vim
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

"Tabs per language
if has("autocmd")
   autocmd FileType python set ts=4 sw=4 et expandtab " Python
   autocmd FileType php set ts=4 sw=4 et expandtab     " Php
   autocmd FileType go set ts=4 sw=4 et expandtab     " Go
   "autocmd FileType yml set ts=2 sw=2 et     " Yaml
   autocmd FileType javascript set ts=2 sw=2           " JS
   autocmd FileType json set ts=2 sw=2 sts=0 expandtab "json
   autocmd FileType ruby   set ts=2 sw=2               " Ruby
   autocmd FileType c,cpp  set ts=4 sw=4 cindent       " C & C++
   autocmd FileType sh set ts=2 sw=2 et expandtab " Bash
   autocmd FileType docbk,html,xhtml,xml set ts=4 sw=4" DocBook, HTML, XHT    ML, and XML
endif

"CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_switch_buffer = 'et'

"Working with buffers
set hidden
nnoremap <space>n :bnext<CR>
nnoremap <space>p :bprev<CR>
nnoremap <space>d :bdelete<CR>
nnoremap <space>l :BufExplorer<CR>

set laststatus=2
" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif
" bind \ (backward slash) to grep shortcut
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>

"vim airline
set laststatus=2
let g:airline_powerline_fonts = 1
let g:bufferline_echo = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#enabled = 0 " turn off the whitespace extension
set noshowmode


if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
"powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.columnr = ''

"tmuxline theme disable autoset via airline
let g:airline#extensions#tmuxline#enabled = 0
"
" Python options
let g:jedi#completions_enabled = 1
let python_highlight_all=1
let g:jedi#show_call_signatures = "2"
let g:syntastic_python_checkers = ["python", "flake8", "pep8"]
set textwidth=78
set colorcolumn=+1
augroup PythonCustomization
  " highlight python self, when followed by a comma, a period or a parenth
   :autocmd FileType python syn match pythonBoolean "\(\W\|^\)\@<=self\([\.]\)\@="
   :autocmd FileType python setlocal completeopt-=preview
augroup END

"See how it works
set mouse=a
noremap <silent> <ScrollWheelDown> :call comfortable_motion#flick(40)<CR>
noremap <silent> <ScrollWheelUp>   :call comfortable_motion#flick(-40)<CR>

"Json
let g:vim_json_syntax_conceal = 0

"Removing trailing spaces

" Strip trailing whitespace option
let stripTrailingWhitespace = 1

"remove trailing whitespaces
nnoremap <leader>e :call <SID>StripTrailingWhitespaces(1, 'n')<CR>
vnoremap <silent> <Leader>e :<C-U>call <SID>StripTrailingWhitespaces(1, 'v')<CR>

"remove all trailing whitespace for specified files before write
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces(0, 'n')

" Remove trailing whitespace
function <SID>StripTrailingWhitespaces(force, mode) range
    if a:force != 1 && g:stripTrailingWhitespace == 0
        return
    endif

    if a:force == 1 || &ft =~ 'python\|rst\|wiki\|javascript\|css\|html\|xml\|json'
        " Preparation: save last search, and cursor position.
        let _s=@/
        let l = line(".")
        let c = col(".")
        " Do the business:
        if a:mode == 'v'
            '<,'>s/\s\+$//e
        else
            %s/\s\+$//e
        endif
        " Clean up: restore previous search history, and cursor position
        let @/=_s
        call cursor(l, c)
    endif
endfunction
command -bang StripTrailingWhitespaces call <SID>StripTrailingWhitespaces(<bang>0, 'n')
