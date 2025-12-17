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
         local cmp = require'cmp'
         cmp.setup({
            completion = {
                autocomplete = false,
            },
            mapping = cmp.mapping.preset.insert({
              ['<C-b>'] = cmp.mapping.scroll_docs(-4),
              ['<C-f>'] = cmp.mapping.scroll_docs(4),
              ['<C-Space>'] = cmp.mapping.complete(),
              ['<C-e>'] = cmp.mapping.abort(),
              ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            }),
        })
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
    --   "zbirenbaum/copilot.lua",
    --   requires = {
    --     "copilotlsp-nvim/copilot-lsp", -- (optional) for NES functionality
    --   },
    --   -- config = function()
    --   --   require("copilot").setup({})
    --   -- end,
    --   cmd = "Copilot",
    --   build = ":Copilot auth",
    --   event = "InsertEnter",
    --   opts = {
    --     suggestion = {
    --       enabled = true,
    --       auto_trigger = true,
    --       keymap = {
    --         accept = "<Tab>",
    --       --   accept = false, -- handled by nvim-cmp / blink.cmp
    --       --   next = "<M-]>",
    --       --   prev = "<M-[>",
    --       },
    --     },
    --     panel = { enabled = false },
    --     filetypes = {
    --       markdown = true,
    --       help = true,
    --     },
    --   },
    -- },
    -- {
    --   "CopilotC-Nvim/CopilotChat.nvim",
    --   dependencies = {
    --     { "zbirenbaum/copilot.lua" }, -- or
    --     { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    --   },
    --   build = "make tiktoken", -- Only on MacOS or Linux
    --   opts = {
    --     -- See Configuration section for options
    --   },
    --   -- See Commands section for default commands if you want to lazy load on them
    -- },
    --
    {
      "tyru/open-browser-github.vim",
        dependencies = {
          "tyru/open-browser.vim",
        },
    },
    {
      "folke/sidekick.nvim",
      enabled = true,
      opts = {},
      keys = {
        {
          "<tab>",
          function()
            -- if there is a next edit, jump to it, otherwise apply it if any
            if not require("sidekick").nes_jump_or_apply() then
              return "<Tab>" -- fallback to normal tab
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
          -- Or to select only installed tools:
          -- require("sidekick.cli").select({ filter = { installed = true } })
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
        -- Example of a keybinding to open Claude directly
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
