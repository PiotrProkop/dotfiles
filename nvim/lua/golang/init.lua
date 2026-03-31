local M = {}

function M.setup()
  require('go').setup({
    goimports = 'gopls',
    gofmt = 'gopls',
    tag_transform = false,
    test_dir = '',
    comment_placeholder = '   ',
    lsp_cfg = false,
    lsp_gofumpt = true,
    lsp_on_attach = false,
    dap_debug = true,
    lsp_keymaps = false,
  })

  -- auto-format with goimports on save
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("GoFormat", { clear = true }),
    pattern = "*.go",
    callback = function()
     require('go.format').goimports()
    end,
  })
end

return M
