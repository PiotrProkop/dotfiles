local lsp = require("lsp")

require'lspconfig'.terraformls.setup{
    on_attach = lsp.on_attach,
}
