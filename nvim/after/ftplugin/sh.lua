vim.opt.ts = 2
vim.opt.sw = 2

local lsp = require("lsp")

require'lspconfig'.bashls.setup{
    on_attach = lsp.on_attach,
}
