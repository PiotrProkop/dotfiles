local M = {}

function M.setup()
  -- packer.nvim configuration
  local conf = {}

  -- Check if packer.nvim is installed
  local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
      fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
      vim.cmd [[packadd packer.nvim]]
      return true
    end
    vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
    return false
  end

  local packer_bootstrap = ensure_packer()

  -- Plugins
  local function plugins(use)
    use { "wbthomason/packer.nvim" }

    -- Vim-Go
    -- use 'fatih/vim-go'

    -- Plenary
    use "nvim-lua/plenary.nvim"

    -- Tagbar
    use {
      "gryf/tagbar",
      branch = "show_tag_kind2",
    }

    -- autocomplete
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'

    -- tmux-vim integration
    use 'christoomey/vim-tmux-navigator'
    use 'tmux-plugins/vim-tmux'

    -- editing
    use 'tpope/vim-surround'
    use 'tpope/vim-unimpaired'
    use 'tpope/vim-repeat'
    use 'tpope/vim-commentary'
    use 'tpope/vim-fugitive'

    use 'junegunn/fzf.vim'
    use 'ojroques/vim-oscyank'  -- clipboard over ssh through tmux

    -- trouble
    use 'nvim-telescope/telescope.nvim'
    use 'kyazdani42/nvim-web-devicons' -- for file icons
    use 'guns/xterm-color-table.vim'
    use 'folke/lsp-colors.nvim'
    use {
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
    }

    -- File manager
    use 'kyazdani42/nvim-tree.lua'

    -- insert blankline with  ] + space
    use 'lukas-reineke/indent-blankline.nvim'

    -- nice scrolling
    use 'yuttie/comfortable-motion.vim'

    use "ellisonleao/gruvbox.nvim"

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
    vim.api.nvim_create_autocmd({'BufEnter','BufAdd','BufNew','BufNewFile','BufWinEnter'}, {
      group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}),
      callback = function()
        vim.opt.foldmethod     = 'expr'
        vim.opt.foldexpr       = 'nvim_treesitter#foldexpr()'
      end
    })

    -- trim whitespaces
    use 'cappyzawa/trim.nvim'

    -- statusline
    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    -- Golang

    use 'ray-x/guihua.lua' -- float term, codeaction and codelens gui support
    use 'ray-x/go.nvim'
    use 'sebdah/vim-delve'

    -- LSP plugins
    use {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    }


    if packer_bootstrap then
      print "Restart Neovim required after installation!"
      require("packer").sync()
    end
  end

  local packer = require "packer"
  packer.init(conf)
  packer.startup(plugins)
end

return M
