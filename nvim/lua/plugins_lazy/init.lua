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

        local capabilities = require("cmp_nvim_lsp").default_capabilities()
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
          -- theme = 'gruvbox-material',
        },
        config = function()
          require('lualine').setup{
              options = {
                section_separators = { left = '', right = '' },
                component_separators = { left = '', right = '' },
            --    theme = 'gruvbox-material',
            }
          }
        end,
     },
     {
        "ray-x/go.nvim",
        dependencies = {  -- optional packages
          -- "ray-x/guihua.lua",
          "neovim/nvim-lspconfig",
          "nvim-treesitter/nvim-treesitter",
          'sebdah/vim-delve',
        },
        config = function()
          require("go").setup()
          require("golang").setup()
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
            automatic_enable = false,
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
    -- {
    --   'codota/tabnine-nvim',
    --   build = './dl_binaries.sh  https://tabnine-poc.hwinf-scm-aws.nvidia.com/update',
    -- },
    -- {
    --   "Exafunction/codeium.nvim",
    --   dependencies = {
    --       "nvim-lua/plenary.nvim",
    --       "hrsh7th/nvim-cmp",
    --   },
    --   config = function()
    --       require("codeium").setup({
    --         api = {
    --            host = "codeium-poc.hwinf-scm-aws.nvidia.com",
    --            path = "_route/api_server",
    --            portal_url = "codeium-poc.hwinf-scm-aws.nvidia.com",
    --         },
    --         enterprise_mode = true,
    --         virtual_text = {
    --           enabled = true,
    --         }
    --       })
    --   end
    -- },
    {
      "zbirenbaum/copilot.lua",
      -- config = function()
      --   require("copilot").setup({})
      -- end,
      cmd = "Copilot",
      build = ":Copilot auth",
      event = "InsertEnter",
      opts = {
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept = "<Tab>",
          --   accept = false, -- handled by nvim-cmp / blink.cmp
          --   next = "<M-]>",
          --   prev = "<M-[>",
          },
        },
        panel = { enabled = false },
        filetypes = {
          markdown = true,
          help = true,
        },
      },
    },
    {
      "CopilotC-Nvim/CopilotChat.nvim",
      dependencies = {
        { "zbirenbaum/copilot.lua" }, -- or
        { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
      },
      build = "make tiktoken", -- Only on MacOS or Linux
      opts = {
        -- See Configuration section for options
      },
      -- See Commands section for default commands if you want to lazy load on them
    },

    {
      "tyru/open-browser-github.vim",
        dependencies = {
          "tyru/open-browser.vim",
        },
    },
    {
      "yetone/avante.nvim",
      -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
      -- ⚠️ must add this setting! ! !
      build = function()
          return "make"
      end,
      event = "VeryLazy",
      version = false, -- Never set this value to "*"! Never!
      ---@module 'avante'
      ---@type avante.Config
      opts = {
        -- add any opts here
        -- for example
        provider = "copilot",
        -- providers = {
        --   claude = {
        --     endpoint = "https://api.anthropic.com",
        --     model = "claude-sonnet-4-20250514",
        --     timeout = 30000, -- Timeout in milliseconds
        --       extra_request_body = {
        --         temperature = 0.75,
        --         max_tokens = 20480,
        --       },
        --   },
        -- },
      },
      dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        --- The below dependencies are optional,
        "echasnovski/mini.pick", -- for file_selector provider mini.pick
        "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
        "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
        "ibhagwan/fzf-lua", -- for file_selector provider fzf
        "stevearc/dressing.nvim", -- for input provider dressing
        "folke/snacks.nvim", -- for input provider snacks
        "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
        "zbirenbaum/copilot.lua", -- for providers='copilot'
      },
    }
  }
end

return M
