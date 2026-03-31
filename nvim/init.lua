local g = vim.g
local opt = vim.opt

vim.keymap.set("", ",", "<Nop>", { silent = true })
g.mapleader = ","
g.maplocalleader = ","

-- buffer navigation
opt.hidden = true
vim.keymap.set("n", "<space>n", ":bnext<CR>", { silent = true })
vim.keymap.set("n", "<space>p", ":bprev<CR>", { silent = true })
vim.keymap.set("n", "<space>d", ":bdelete<CR>", { silent = true })

-- window navigation
vim.keymap.set("", "<C-h>", "<C-w>h", { silent = true })
vim.keymap.set("", "<C-j>", "<C-w>j", { silent = true })
vim.keymap.set("", "<C-k>", "<C-w>k", { silent = true })
vim.keymap.set("", "<C-l>", "<C-w>l", { silent = true })

-- terminal navigation: exit terminal mode with Esc, navigate with C-hjkl
vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h", { silent = true })
vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j", { silent = true })
vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k", { silent = true })
vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l", { silent = true })
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { silent = true })

opt.termguicolors = true
opt.hlsearch = true
opt.mouse = "a"
opt.breakindent = true
opt.undofile = true
opt.ignorecase = true
opt.smartcase = true
opt.updatetime = 250
opt.signcolumn = "yes"
opt.backup = false
opt.clipboard = 'unnamedplus'
opt.wildmenu = true
opt.incsearch = true
opt.maxmempattern = 2000000
opt.completeopt = 'menuone,noinsert,noselect'
opt.foldenable = false
opt.background = 'dark'

opt.number = true
opt.relativenumber = true
opt.ts = 4
opt.sw = 4
opt.autoindent = true
opt.expandtab = true
opt.showmatch = true

local augroup = vim.api.nvim_create_augroup("CustomSettings", { clear = true })

-- disable auto-wrap comments (c), don't insert comment leader after 'o' (o),
-- but do insert after <CR> (r) and respect numbered lists (n)
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "o" })
    vim.opt_local.formatoptions:append({ "r", "n" })
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup,
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- bootstrap lazy.nvim if not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(require("plugins_lazy").config())

-- manual completion triggers: <C-x><C-o> for LSP, <C-x><C-s> for snippets
vim.keymap.set("i", "<C-x><C-o>", "<Cmd>lua vimrc.cmp.lsp()<CR>", { silent = true })
vim.keymap.set("i", "<C-x><C-s>", "<Cmd>lua vimrc.cmp.snippet()<CR>", { silent = true })

-- copy yanked text to system clipboard over SSH via OSC52 escape sequence
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    if vim.v.event.operator == 'y' and vim.v.event.regname == '' then
      require('osc52').copy_register('')
    end
  end,
})

-- :Bterm opens a small terminal split at the bottom
vim.api.nvim_create_user_command("Bterm", "bo split | resize 10 | term", {})

-- defer LSP setup so cmp_nvim_lsp doesn't force-load at startup
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  once = true,
  callback = function()
    require("lsp_custom").setup()
  end,
})

vim.cmd([[colorscheme gruvbox]])
