local M = {}

function M.setup()
  local cmp = require('cmp')

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    -- no auto-popup; completion is triggered manually via <C-Space> or <C-x><C-o>/<C-x><C-s>
    completion = {
      autocomplete = false,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-n>'] = cmp.mapping.select_next_item(),
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    -- primary sources (LSP, snippets) with buffer as fallback
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
    }, {
      { name = 'buffer' },
    })
  })

  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- global functions used by <C-x><C-o> and <C-x><C-s> keymaps in init.lua
  -- to trigger completion with a specific source only
  _G.vimrc = _G.vimrc or {}
  _G.vimrc.cmp = _G.vimrc.cmp or {}
  _G.vimrc.cmp.lsp = function()
    cmp.complete({ config = { sources = {{ name = 'nvim_lsp' }} } })
  end
  _G.vimrc.cmp.snippet = function()
    cmp.complete({ config = { sources = {{ name = 'vsnip' }} } })
  end
end

return M
