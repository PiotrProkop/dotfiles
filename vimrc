set nocompatible              " be iMproved, required
set nobackup                  " Don't keep backup file
set clipboard=unnamed        " Yank and paste with the system clipboard
set clipboard+=unnamedplus " Yank and paste with the system clipboard
set encoding=utf-8
let g:python3_host_prog  = '/usr/bin/python3'
set relativenumber

filetype off                  " required
if !has('nvim') && has('python3') && !has('patch-8.1.201')
    silent! python3 1
endif

if has('nvim')
    call plug#begin('~/.local/share/nvim/plugged')
else
    call plug#begin('~/.vim/plugged')
endif
 Plug 'habamax/vim-asciidoctor'
 Plug 'Rykka/riv.vim', { 'for': 'rst' }
 Plug 'scrooloose/nerdtree'
 Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
 Plug 'gryf/tagbar', {'branch': 'show_tag_kind2'}
 Plug 'morhetz/gruvbox'
 Plug 'tpope/vim-fugitive'
 Plug 'christoomey/vim-tmux-navigator'
 Plug 'tpope/vim-commentary'
 Plug 'yuttie/comfortable-motion.vim'
 Plug 'stephpy/vim-yaml'
 Plug 'elzr/vim-json'
 Plug 'tpope/vim-surround'
 Plug 'tpope/vim-unimpaired'
 Plug 'tpope/vim-repeat'
 Plug 'tmux-plugins/vim-tmux'
 Plug 'gcmt/taboo.vim'
 Plug 'guns/xterm-color-table.vim'
 Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
 Plug 'junegunn/fzf.vim'
 Plug 'hashivim/vim-terraform'
 Plug 'nvim-lua/popup.nvim'
 Plug 'nvim-lua/plenary.nvim'
 Plug 'nvim-telescope/telescope.nvim'
 Plug 'sebdah/vim-delve'
 Plug 'chr4/nginx.vim'
 Plug 'xolox/vim-misc'
 Plug 'xolox/vim-lua-ftplugin'

 Plug 'neovim/nvim-lspconfig'
 Plug 'hrsh7th/cmp-nvim-lsp'
 Plug 'hrsh7th/cmp-buffer'
 Plug 'hrsh7th/cmp-path'
 Plug 'hrsh7th/nvim-cmp'
 Plug 'hrsh7th/cmp-vsnip'
 Plug 'hrsh7th/vim-vsnip'

 Plug 'kyazdani42/nvim-web-devicons' " for file icons
 Plug 'kyazdani42/nvim-tree.lua'
 Plug 'lukas-reineke/indent-blankline.nvim'

 Plug 'folke/trouble.nvim'
 Plug 'folke/lsp-colors.nvim'

 Plug 'romgrk/barbar.nvim'
call plug#end()            " required

filetype plugin indent on    " required
set shortmess+=c

" better menu
set wildmenu
" search while typing
set incsearch

syntax on
"change mapleader
let mapleader=","

if has('gui_running')
    set background=dark
    set guioptions=
    set guifont=Hack\ 14
    set noerrorbells
    set novisualbell
    set t_vb=
    autocmd! GUIEnter * set vb t_vb=
else
    set background=dark
endif


set maxmempattern=2000000

color gruvbox
" Gruvbox colorscheme
let g:gruvbox_contrast_dark = "hard"
let g:gruvbox_contrast_light = "soft"

"Highlight active column and line
set lazyredraw

" NOTE: If barbar's option dict isn't created yet, create it
let bufferline = get(g:, 'bufferline', {})

"Telescope
" Find files using Telescope command-line sugar.
nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <space>r <cmd>Telescope live_grep<cr>
nnoremap <space>l <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect




"inoremap <silent><expr> <tab>     compe#complete()
" inoremap <silent><expr> <CR>      compe#confirm('<CR>')
" inoremap <silent><expr> <C-e>     compe#close('<C-e>')
" inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
" inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })


inoremap <C-x><C-o> <Cmd>lua vimrc.cmp.lsp()<CR>
inoremap <C-x><C-s> <Cmd>lua vimrc.cmp.snippet()<CR>

lua << EOF
local cmp = require('cmp')
  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
      ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })


  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['gopls'].setup {
    capabilities = capabilities
  }

    _G.vimrc = _G.vimrc or {}
    _G.vimrc.cmp = _G.vimrc.cmp or {}
    _G.vimrc.cmp.lsp = function()
      cmp.complete({
        config = {
          sources = {
            { name = 'nvim_lsp' }
          }
        }
      })
    end
    _G.vimrc.cmp.snippet = function()
      cmp.complete({
        config = {
          sources = {
            { name = 'vsnip' }
          }
        }
      })
    end
    _G.vimrc = _G.vimrc or {}
    _G.vimrc.cmp = _G.vimrc.cmp or {}
    _G.vimrc.cmp.on_text_changed = function()
      local cursor = vim.api.nvim_win_get_cursor(0)
      local line = vim.api.nvim_get_current_line()
      local before = string.sub(line, 1, cursor[2] + 1)
      if before:match('%s*$') then
        cmp.complete() -- Trigger completion only if the cursor is placed at the end of line.
      end
    end
EOF


autocmd FileType terraform setlocal omnifunc=v:lua.vim.lsp.omnifunc
autocmd FileType terraform set completeopt -=preview

autocmd FileType tf setlocal omnifunc=v:lua.vim.lsp.omnifunc
autocmd FileType tf set completeopt -=preview

autocmd FileType go setlocal omnifunc=v:lua.vim.lsp.omnifunc
autocmd FileType go set completeopt -=preview

lua << EOF
local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)

    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap=true, silent=true }
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-m>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
end

require'lspconfig'.gopls.setup{
    on_attach = on_attach,
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
          fieldalignment = true,
        },
        codelenses = {
          gc_details = true,
        },
        staticcheck = true,
      },
    },
}

require'lspconfig'.terraformls.setup{
    on_attach = on_attach,
}

EOF

function! s:check_back_space() abort "{{{
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

"Golang highligt
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 0
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"

let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_rename_command = 'gopls'
set updatetime=100

set number
set ts=4
set sw=4
set autoindent
set expandtab
set showmatch

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

" nmap <F8> :TagbarToggle<CR>

" NERDTree
" nmap <leader>m :NERDTreeToggle<CR>
" let NERDTreeHighlightCursorline=1
" let NERDTreeIgnore = ['tmp', '.yardoc']
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

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
autocmd FileType python set ts=4 sw=4 et expandtab " Python
autocmd FileType php set ts=4 sw=4 et expandtab     " Php
autocmd FileType go set ts=4 sw=4 et expandtab     " Go
autocmd FileType vim set ts=4 sw=4 et
autocmd FileType javascript set ts=2 sw=2           " JS
autocmd FileType json set ts=2 sw=2 sts=0 expandtab "json
autocmd FileType ruby   set ts=2 sw=2               " Ruby
autocmd FileType c,cpp  set ts=4 sw=4 cindent       " C & C++
autocmd FileType sh set ts=2 sw=2 et expandtab " Bash
autocmd FileType docbk,html,xhtml,xml set ts=4 sw=4 " DocBook, HTML, XHT    ML, and XML
" Yaml
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType yml setlocal ts=2 sts=2 sw=2 expandtab

"Working with buffers
set hidden
nnoremap <space>n :bnext<CR>
nnoremap <space>p :bprev<CR>
nnoremap <space>d :bdelete<CR>

"See how it works
set mouse=a
noremap <silent> <ScrollWheelDown> :call comfortable_motion#flick(40)<CR>
noremap <silent> <ScrollWheelUp>   :call comfortable_motion#flick(-40)<CR>

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


" Change Color when entering Insert Mode
autocmd InsertEnter * highlight  CursorLine guibg=#323D3E
autocmd InsertEnter * highlight  Cursor guibg=#00AAFF

" Live substitute
if has('nvim')
    set inccommand=split
endif

" Statusline
let g:currentmode={
    \ 'n'  : 'N ',
    \ 'no' : 'N·Operator Pending ',
    \ 'v'  : 'V ',
    \ 'V'  : 'V·Line ',
    \ "\<C-v>" : 'V·Block ',
    \ 's'  : 'Select ',
    \ 'S'  : 'S·Line ',
    \ 'i'  : 'I ',
    \ 'R'  : 'R ',
    \ 'Rv' : 'V·Replace ',
    \ 'c'  : 'Command ',
    \ 'cv' : 'Vim Ex ',
    \ 'ce' : 'Ex ',
    \ 'r'  : 'Prompt ',
    \ 'rm' : 'More ',
    \ 'r?' : 'Confirm ',
    \ '!'  : 'Shell ',
    \ 't'  : 'Terminal '
    \}

" Automatically change the statusline color depending on mode
function! ChangeStatuslineColor()
    let l:mode = mode()
    if (l:mode =~# '\v(n|no)')
        exe 'hi! StatusLine ctermfg=236'
    elseif (l:mode =~# '\v(v|V)' || g:currentmode[l:mode] ==# 'V·Block' || get(g:currentmode, l:mode, '') ==# 't')
        exe 'hi! StatusLine ctermfg=005'
    elseif (l:mode ==# 'i')
        exe 'hi! StatusLine ctermfg=004'
    else
        exe 'hi! StatusLine ctermfg=006'
    endif
    return ''
endfunction

function! GitInfo()
  let git = fugitive#head()
  if git != ''
    return '  '.fugitive#head()
  else
    return ''
endfunction

set noshowmode
set laststatus=2
set ruler
set statusline=
set statusline+=%3.3{ChangeStatuslineColor()}               " Changing the statusline color
set statusline+=%0*\ %{toupper(g:currentmode[mode()])}   " Current mode
" set statusline+=%3*%{GitInfo()}                      " Git Branch name
set statusline+=%1*\ %t%m\ \                                 " File+modified
set statusline+=\ %#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}             " Syntastic errors
set statusline+=%*
set statusline+=%2*\ %=                                  " Space
set statusline+=%3*%{exists(':Tagbar')!=0?tagbar#currenttag('%s','','f'):''} " current tag
set statusline+=%3*%{exists(':Tagbar')!=0?tagbar#currenttagtype('(%s)',''):''} " current tag type
set statusline+=%2*\ %y\                                 " FileType
"set statusline+=%2*\ %{(&fenc!=''?&fenc:&enc)}\ \[%{&ff}]\ " Encoding & Fileformat
set statusline+=%0*%3p%%\ \|                              " Rownumber/total (%)
set statusline+=%0*\ %l:%c\                               " Line/char

hi User1 ctermfg=011
hi User1 ctermbg=237
hi User2 ctermfg=011
hi User2 ctermbg=237
hi User3 ctermfg=013
hi User3 ctermbg=237

" Terraform
let g:terraform_align=1
" let g:terraform_fmt_on_save=1

lua << EOF
require'nvim-tree'.setup {
}
EOF

" nvim-tree
"
nmap <leader>m :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>

" default will show icon by default if no icon is provided
" default shows no icon by default
let g:nvim_tree_icons = {
    \ 'default': '',
    \ 'symlink': '',
    \ 'git': {
    \   'unstaged': "✗",
    \   'staged': "✓",
    \   'unmerged': "",
    \   'renamed': "➜",
    \   'untracked': "★",
    \   'deleted': "",
    \   'ignored': "◌"
    \   },
    \ 'folder': {
    \   'arrow_open': "",
    \   'arrow_closed': "",
    \   'default': "",
    \   'open': "",
    \   'empty': "",
    \   'empty_open': "",
    \   'symlink': "",
    \   'symlink_open': "",
    \   },
    \   'lsp': {
    \     'hint': "",
    \     'info': "",
    \     'warning': "",
    \     'error': "",
    \   }
    \ }

" indent-blankline
let g:indent_blankline_space_char = '.'
let g:indent_blankline_show_end_of_line = v:true

lua << EOF
require("indent_blankline").setup {
    char = "|",
    buftype_exclude = {"terminal"}
}
EOF

nnoremap <space>t <cmd>TroubleToggle document_diagnostics<cr>
nnoremap gR <cmd>TroubleToggle lsp_references<cr>
" Trouble settings
lua << EOF
  require("trouble").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
  local actions = require("telescope.actions")
  local trouble = require("trouble.providers.telescope")

  local telescope = require("telescope")

  telescope.setup {
    defaults = {
      mappings = {
        i = { ["<c-t>"] = trouble.open_with_trouble },
        n = { ["<c-t>"] = trouble.open_with_trouble },
      },
    },
  }
EOF
