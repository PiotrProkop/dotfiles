local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<C-]>', vim.lsp.buf.definition, opts)

local lsp = require("lsp")

require'lspconfig'.gopls.setup{
    on_attach = lsp.on_attach,
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
          fieldalignment = true,
        },
        codelenses = {
          gc_details = true,
        },
        staticcheck = true,
      },
    },
}
