local M = {}

function M.config()
  return {
    {
      "/sainnhe/gruvbox-material",
      lazy = false, -- make sure we load this during startup if it is your main colorscheme
      priority = 1000, -- make sure to load this before all the other start plugins
      dependencies = { 'folke/lsp-colors.nvim' },
      config = function()
        -- load the colorscheme here
        vim.cmd([[colorscheme gruvbox-material]])
        vim.g.gruvbox_material_background = 'hard'
      end,
    },
    {
      "nvim-lua/plenary.nvim",
      lazy = true,
    },
    {
      "gryf/tagbar",
      branch = "show_tag_kind2",
      lazy = false,
    },
    {
      'hrsh7th/nvim-cmp',
      -- load cmp on InsertEnter
      event = "InsertEnter",
      dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "neovim/nvim-lspconfig",
        'hrsh7th/cmp-vsnip',
        'hrsh7th/vim-vsnip',
        'hrsh7th/cmp-path',
      },
      keys = {
        {"<C-x><C-o>", "<Cmd>lua vimrc.cmp.lsp()<CR>", desc = "Cmp", mode = "i"},
      },
      config = function()
        require("autocomplete").setup()
      end
    },
    {
       'christoomey/vim-tmux-navigator',
    },
    {
      "kylechui/nvim-surround",
      version = "*", -- Use for stability; omit to use `main` branch for the latest features
      event = "VeryLazy",
      config = function()
          require("nvim-surround").setup({
              -- Configuration here, or leave empty to use defaults
          })
      end
    },
    {
      "terrortylor/nvim-comment",
      event = "VeryLazy",
      config = function()
          require("nvim_comment").setup({
              -- Configuration here, or leave empty to use defaults
          })
      end
    },
    {
      "folke/trouble.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
     'nvim-telescope/telescope.nvim',
      lazy = true,
      keys = {
        {"<C-p>", ":Telescope find_files<CR>", desc = "Telescope"},
        {"<space>l", ":Telescope buffers<CR>", desc = "Telescope"},
        {"<space>r", ":Telescope live_grep<CR>", desc = "Telescope"},
      },
    },
    {
      "nvim-tree/nvim-tree.lua",
      version = "*",
      lazy = false,
      dependencies = {
        "nvim-tree/nvim-web-devicons",
      },
      keys = {
        {"<leader>m", ":NvimTreeToggle<CR>", desc = "NvimTree"},
        {"<leader>r", ":NvimTreeRefresh<CR>", desc = "NvimTree"},
      },
      config = function()
        require("nvim-tree").setup {}
      end,
    },
    {
      'lukas-reineke/indent-blankline.nvim',
      main = "ibl",
      opts = {
            char = "|",
            buftype_exclude = {"terminal"}
      },
      config = function()
        require("ibl").setup()
      end
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function ()
          local configs = require("nvim-treesitter.configs")

          configs.setup({
              modules = {},
              ensure_installed = { "go", "lua", "vim", "vimdoc", "yaml", "json", "html" },
              ignore_install = {},
              auto_install = true,
              sync_install = false,
              highlight = { enable = true },
              indent = { enable = true },
            })
        end
     },
     {
        'nvim-treesitter/nvim-treesitter-context',
        config = function()
          require("treesitter-context").setup()
        end,
     },
     {
      "cappyzawa/trim.nvim",
        config = function()
          require("trim").setup()
        end,
     },
     {
        'nvim-lualine/lualine.nvim',
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000,
        dependencies = {
          "nvim-tree/nvim-web-devicons",
        },
        options = {
          section_separators = { left = '', right = '' },
          component_separators = { left = '', right = '' },
          theme = 'gruvbox-material',
        },
        config = function()
          require('lualine').setup{
              options = {
                section_separators = { left = '', right = '' },
                component_separators = { left = '', right = '' },
                theme = 'gruvbox-material',
            }
          }
        end,
     },
     {
        "ray-x/go.nvim",
        dependencies = {  -- optional packages
          "ray-x/guihua.lua",
          "neovim/nvim-lspconfig",
          "nvim-treesitter/nvim-treesitter",
          'sebdah/vim-delve',
        },
        config = function()
          require("go").setup()
          require("lsp_custom").setup()
        end,
        event = {"CmdlineEnter"},
        ft = {"go", 'gomod'},
        build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
    },
    {
      "williamboman/mason.nvim",
      config = function()
        require("mason").setup()
      end,
    },
    {
      "williamboman/mason-lspconfig.nvim",
      config = function()
        require("mason-lspconfig").setup(
          {
            ensure_installed = {"gopls", "bashls", "lua_ls", "pylsp", "yamlls"},
          }
        )
      end,
    },
    {
        'ojroques/nvim-osc52',
    },
    {
        'tpope/vim-fugitive',
    },
  }
end

return M
