local M = {}

function M.setup()
  -- shared on_attach: sets buffer-local keymaps and enables inline completion
  -- when the LSP server supports it (e.g. copilot)
  local lsp = {
    on_attach = function(client, bufnr)
      vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

      local opts = { noremap=true, silent=true, buffer=bufnr }
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
      vim.keymap.set('n', '<C-m>', vim.lsp.buf.signature_help, opts)
      vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
      vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
      vim.keymap.set('n', '<space>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
      vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
      vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
      vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
      vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

      if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlineCompletion, bufnr) then
        vim.lsp.inline_completion.enable(true, { bufnr = bufnr })
        vim.keymap.set('i', '<C-f>', vim.lsp.inline_completion.get,
          { desc = 'LSP: accept inline completion', buffer = bufnr })
        vim.keymap.set('i', '<C-g>', vim.lsp.inline_completion.select,
          { desc = 'LSP: switch inline completion', buffer = bufnr })
      end
    end
  }

  vim.opt.omnifunc = 'v:lua.vim.lsp.omnifunc'

  -- extend default LSP capabilities with nvim-cmp completion support
  local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

  vim.lsp.config("gopls", {
    capabilities = capabilities,
    on_attach = lsp.on_attach,
    settings = {
      gopls = {
        analyses = { unusedparams = true },
        codelenses = { gc_details = true },
        staticcheck = true,
      },
    },
  })
  vim.lsp.enable('gopls')

  vim.lsp.config("lua_ls", {
    capabilities = capabilities,
    on_attach = lsp.on_attach,
    settings = {
      Lua = {
        runtime = { version = 'LuaJIT' },
        diagnostics = { globals = {'vim'} },
        workspace = { library = vim.api.nvim_get_runtime_file("", true) },
        telemetry = { enable = false },
      },
    },
  })
  vim.lsp.enable('lua_ls')

  vim.lsp.config("bashls", {
    capabilities = capabilities,
    on_attach = lsp.on_attach,
  })
  vim.lsp.enable('bashls')

  vim.lsp.config("pylsp", {
    capabilities = capabilities,
    on_attach = lsp.on_attach,
  })
  vim.lsp.enable('pylsp')

  vim.lsp.config("yamlls", {
    capabilities = capabilities,
    redhat = { telemetry = { enabled = false } },
  })
  vim.lsp.enable('yamlls')

  vim.lsp.config("copilot", {
    capabilities = capabilities,
    on_attach = lsp.on_attach,
  })
  vim.lsp.enable('copilot')

  vim.lsp.config('rust_analyzer', {
    filetypes = { "rust" },
    capabilities = capabilities,
    on_attach = lsp.on_attach,
    settings = {
      ['rust-analyzer'] = {
        diagnostics = { enable = false },
      },
    },
  })
  vim.lsp.enable('rust_analyzer')
end

return M
