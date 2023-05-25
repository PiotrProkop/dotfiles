-- Use custom comment leaders to allow both nested variants (`--` and `----`)
-- and "docgen" variant (`---`).
vim.cmd([[setlocal comments=:---,:--]])
vim.opt.ts = 2
vim.opt.sw = 2
