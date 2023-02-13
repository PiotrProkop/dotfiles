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


-- use packer to install plugins
require("plugins").setup()

-- Mason
require("mason").setup()
-- require("mason-lspconfig").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "sumneko_lua" }
})

-- setup cmp
require("autocomplete").setup()
api.nvim_set_keymap("i", "<C-x><C-o>", "<Cmd>lua vimrc.cmp.lsp()<CR>", { noremap = true, silent = true })
api.nvim_set_keymap("i", "<C-x><C-s>", "<Cmd>lua vimrc.cmp.snippet()<CR>", { noremap = true, silent = true })

-- nvim-tree
require'nvim-tree'.setup()
api.nvim_set_keymap("n", "<leader>m", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
api.nvim_set_keymap("n", "<leader>r", ":NvimTreeRefresh<CR>", { noremap = true, silent = true })

require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  auto_install = true,
}

-- trim whitespaces
require('trim').setup()

-- indent blankline
require("indent_blankline").setup {
    char = "|",
    buftype_exclude = {"terminal"}
}

-- trouble
require("trouble").setup {}
-- local actions = require("telescope.actions")
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

vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", {silent = true, noremap = true})
vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", {silent = true, noremap = true})
vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", {silent = true, noremap = true})
vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", {silent = true, noremap = true})
vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", {silent = true, noremap = true})
vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", {silent = true, noremap = true})

-- statusline
require('lualine').setup{
    options = {
      section_separators = { left = '', right = '' },
      component_separators = { left = '', right = '' },
      theme = 'gruvbox-material',
  }
}


-- Load the colorscheme
vim.o.background = "dark" -- or "light" for light mode
vim.cmd[[ colorscheme melange ]]

-- ssh yank
local copy = function()
  if vim.v.event.operator == 'y' and vim.v.event.regname == '' then
    require('osc52').copy_register('')
  end
end

vim.api.nvim_create_autocmd('TextYankPost', {callback = copy})

-- enable impatient
require('impatient')

-- enable neoscroll
require('neoscroll').setup()

-- enable treesitter context
require'treesitter-context'.setup()

vim.g.neovide_input_use_logo = 1
vim.api.nvim_set_keymap('', '<D-v>', '+p<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('!', '<D-v>', '<C-R>+', { noremap = true, silent = true})
vim.api.nvim_set_keymap('t', '<D-v>', '<C-R>+', { noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<D-v>', '<C-R>+', { noremap = true, silent = true})

-- easy terminal navigation
-- nvim_set_keymap doesn't work
vim.cmd [[
  tnoremap <C-h> <C-\><C-n><C-w>h
  tnoremap <C-j> <C-\><C-n><C-w>j
  tnoremap <C-k> <C-\><C-n><C-w>k
  tnoremap <C-l> <C-\><C-n><C-w>l
  tnoremap <Esc> <C-\><C-n>
]]
api.nvim_create_user_command("Bterm", "bo split | resize 10 | term", {})

require('aerial').setup({
  -- optionally use on_attach to set keymaps when aerial has attached to a buffer
  on_attach = function(bufnr)
    -- Jump forwards/backwards with '{' and '}'
    vim.keymap.set('n', ']', '<cmd>AerialPrev<CR>', {buffer = bufnr})
    vim.keymap.set('n', '[', '<cmd>AerialNext<CR>', {buffer = bufnr})
  end
})
