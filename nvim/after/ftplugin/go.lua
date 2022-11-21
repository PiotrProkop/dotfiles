local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<C-]>', vim.lsp.buf.definition, opts)
