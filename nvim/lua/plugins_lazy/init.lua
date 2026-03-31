local M = {}

function M.config()
  return {
    {
      { "ellisonleao/gruvbox.nvim"},
    },
    {
      "nvim-lua/plenary.nvim",
      lazy = true,
    },
    {
      "gryf/tagbar",
      branch = "show_tag_kind2",
      cmd = "TagbarToggle",
    },
    {
      'hrsh7th/nvim-cmp',
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
       event = "VeryLazy",
    },
    {
      "kylechui/nvim-surround",
      version = "*",
      event = "VeryLazy",
      config = function()
          require("nvim-surround").setup({})
      end
    },
    {
      "terrortylor/nvim-comment",
      event = "VeryLazy",
      config = function()
          require("nvim_comment").setup({})
      end
    },
    {
      "folke/trouble.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      cmd = "Trouble",
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
      cmd = "NvimTreeToggle",
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
      event = "BufReadPost",
      config = function()
        require("ibl").setup()
      end
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = "BufReadPost",
        config = function ()
          require("nvim-treesitter.configs").setup({
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
        event = "BufReadPost",
        config = function()
          require("treesitter-context").setup()
        end,
     },
     {
      "cappyzawa/trim.nvim",
        event = "BufWritePre",
        config = function()
          require("trim").setup()
        end,
     },
     {
        'nvim-lualine/lualine.nvim',
        lazy = false,
        priority = 1000,
        dependencies = {
          "nvim-tree/nvim-web-devicons",
        },
        config = function()
          require('lualine').setup{
              options = {
                section_separators = { left = '', right = '' },
                component_separators = { left = '', right = '' },
            }
          }
        end,
     },
     {
        "ray-x/go.nvim",
        dependencies = {
          "neovim/nvim-lspconfig",
          "nvim-treesitter/nvim-treesitter",
          'sebdah/vim-delve',
        },
        config = function()
          require("go").setup()
          require("golang").setup()
        end,
        ft = {"go", 'gomod'},
        build = ':lua require("go.install").update_all_sync()'
    },
    {
      "williamboman/mason.nvim",
      event = "VeryLazy",
      config = function()
        require("mason").setup()
      end,
    },
    {
      -- auto-installs LSP servers listed in ensure_installed via mason
      "williamboman/mason-lspconfig.nvim",
      event = "VeryLazy",
      dependencies = { "williamboman/mason.nvim" },
      config = function()
        require("mason-lspconfig").setup({
            ensure_installed = {"gopls", "bashls", "lua_ls", "pylsp", "yamlls"},
            automatic_enable = false,
        })
      end,
    },
    {
        'ojroques/nvim-osc52',
        lazy = true,
    },
    {
        'tpope/vim-fugitive',
        cmd = "Git",
    },
    {
      "tyru/open-browser-github.vim",
        cmd = { "OpenGithubFile", "OpenGithubIssue", "OpenGithubPullReq", "OpenGithubProject" },
        dependencies = {
          "tyru/open-browser.vim",
        },
    },
    {
      "folke/sidekick.nvim",
      opts = {},
      keys = {
        {
          "<tab>",
          function()
            if not require("sidekick").nes_jump_or_apply() then
              return "<Tab>"
            end
          end,
          expr = true,
          desc = "Goto/Apply Next Edit Suggestion",
        },
        {
          "<c-.>",
          function() require("sidekick.cli").toggle() end,
          desc = "Sidekick Toggle",
          mode = { "n", "t", "i", "x" },
        },
        {
          "<leader>aa",
          function() require("sidekick.cli").toggle() end,
          desc = "Sidekick Toggle CLI",
        },
        {
          "<leader>as",
          function() require("sidekick.cli").select() end,
          desc = "Select CLI",
        },
        {
          "<leader>ad",
          function() require("sidekick.cli").close() end,
          desc = "Detach a CLI Session",
        },
        {
          "<leader>at",
          function() require("sidekick.cli").send({ msg = "{this}" }) end,
          mode = { "x", "n" },
          desc = "Send This",
        },
        {
          "<leader>af",
          function() require("sidekick.cli").send({ msg = "{file}" }) end,
          desc = "Send File",
        },
        {
          "<leader>av",
          function() require("sidekick.cli").send({ msg = "{selection}" }) end,
          mode = { "x" },
          desc = "Send Visual Selection",
        },
        {
          "<leader>ap",
          function() require("sidekick.cli").prompt() end,
          mode = { "n", "x" },
          desc = "Sidekick Select Prompt",
        },
        {
          "<leader>ac",
          function() require("sidekick.cli").toggle({ name = "claude", focus = true }) end,
          desc = "Sidekick Toggle Claude",
        },
      },
    },
  }
end

return M
