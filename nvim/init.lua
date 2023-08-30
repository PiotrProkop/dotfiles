local api = vim.api
local g = vim.g
local opt = vim.opt


-- Remap leader and local leader to <Space>
api.nvim_set_keymap("", ",", "<Nop>", { noremap = true, silent = true })
g.mapleader = ","
g.maplocalleader = ","

-- working with buffers
opt.hidden = true
api.nvim_set_keymap("n", "<space>n", ":bnext<CR>", { noremap = true, silent = true })
api.nvim_set_keymap("n", "<space>p", ":bprev<CR>", { noremap = true, silent = true })
api.nvim_set_keymap("n", "<space>d", ":bdelete<CR>", { noremap = true, silent = true })

-- easy window navigation
api.nvim_set_keymap("", "<C-h>", "<C-w>h", { noremap = true, silent = true })
api.nvim_set_keymap("", "<C-j>", "<C-w>j", { noremap = true, silent = true })
api.nvim_set_keymap("", "<C-k>", "<C-w>k", { noremap = true, silent = true })
api.nvim_set_keymap("", "<C-l>", "<C-w>l", { noremap = true, silent = true })

opt.termguicolors = true -- Enable colors in terminal
opt.hlsearch = true --Set highlight on search
opt.mouse = "a" --Enable mouse mode
opt.breakindent = true --Enable break indent
opt.undofile = true --Save undo history
opt.ignorecase = true --Case insensitive searching unless /C or capital in search
opt.smartcase = true -- Smart case
opt.updatetime = 250 --Decrease update time
opt.signcolumn = "yes" -- Always show sign column
opt.backup = false -- do not use backup files
opt.clipboard = 'unnamedplus' -- use system clipboard
opt.wildmenu = true -- better menu
opt.incsearch = true -- search while typing
opt.maxmempattern = 2000000
opt.completeopt = 'menuone,noinsert,noselect' -- better completion experience
opt.foldenable = false
opt.background = 'dark'

-- editing
opt.number = true --Make line numbers default
opt.relativenumber = true --Make relative number default
opt.ts = 4
opt.sw = 4
opt.autoindent = true
opt.expandtab = true
opt.showmatch = true

-- Telescope
-- Find files using Telescope command-line sugar.
api.nvim_set_keymap("n", "<C-p>", ":Telescope find_files<CR>", { noremap = true, silent = true })
api.nvim_set_keymap("n", "<space>r", ":Telescope live_grep<CR>", { noremap = true, silent = true })
api.nvim_set_keymap("n", "<space>l", ":Telescope buffers<CR>", { noremap = true, silent = true })

-- Custom autocommands ========================================================
vim.cmd([[augroup CustomSettings]])
  vim.cmd([[autocmd!]])

  -- Don't auto-wrap comments and don't insert comment leader after hitting 'o'
  vim.cmd([[autocmd FileType * setlocal formatoptions-=c formatoptions-=o]])
  -- But insert comment leader after hitting <CR> and respect 'numbered' lists
  vim.cmd([[autocmd FileType * setlocal formatoptions+=r formatoptions+=n]])

  -- Highlight yanked text
  vim.cmd([[autocmd TextYankPost * silent! lua vim.highlight.on_yank()]])
vim.cmd([[augroup END]])

-- easy terminal navigation
-- nvim_set_keymap doesn't work
vim.cmd [[
  tnoremap <C-h> <C-\><C-n><C-w>h
  tnoremap <C-j> <C-\><C-n><C-w>j
  tnoremap <C-k> <C-\><C-n><C-w>k
  tnoremap <C-l> <C-\><C-n><C-w>l
  tnoremap <Esc> <C-\><C-n>
]]

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- use packer to install plugins
require("lazy").setup(require("plugins_lazy").config())

-- -- setup cmp
api.nvim_set_keymap("i", "<C-x><C-o>", "<Cmd>lua vimrc.cmp.lsp()<CR>", { noremap = true, silent = true })
api.nvim_set_keymap("i", "<C-x><C-s>", "<Cmd>lua vimrc.cmp.snippet()<CR>", { noremap = true, silent = true })

-- ssh yank
local copy = function()
  if vim.v.event.operator == 'y' and vim.v.event.regname == '' then
    require('osc52').copy_register('')
  end
end

vim.api.nvim_create_autocmd('TextYankPost', {callback = copy})

api.nvim_create_user_command("Bterm", "bo split | resize 10 | term", {})

-- load lsp
require("lsp_custom").setup()
