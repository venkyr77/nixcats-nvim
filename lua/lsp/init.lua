require("lz.n").trigger_load("blink.cmp")

require("lsp.configs.nixd")
require("lsp.configs.ts_ls")

vim.lsp.enable({ "nixd" })
vim.lsp.enable({ "ts_ls" })
