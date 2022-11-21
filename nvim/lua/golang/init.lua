local M = {}

function M.setup()
  -- Golang
  require('guihua.maps').setup()
  require 'go'.setup({
    goimport = 'gopls', -- if set to 'gopls' will use golsp format
    gofmt = 'gopls', -- if set to gopls will use golsp format
    max_line_len = 120,
    tag_transform = false,
    test_dir = '',
    comment_placeholder = '   ',
    lsp_cfg = true, -- false: use your own lspconfig
    lsp_gofumpt = true, -- true: set default gofmt in gopls format to gofumpt
    lsp_on_attach = true, -- use on_attach from go.nvim
    dap_debug = true,
  })

  local format_sync_grp = vim.api.nvim_create_augroup("format", { clear = true })

  -- Run gofmt + goimport on save
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
     require('go.format').goimport()
    end,
    group = format_sync_grp,
  })
end

return M
