local lzn = require("lz.n")

lzn.trigger_load("blink.cmp")

local base_capabilities = require("blink.cmp").get_lsp_capabilities()

vim.lsp.config.lua_ls = require("lsp.configs.lua_ls").get(base_capabilities)
vim.lsp.config.nixd = require("lsp.configs.nixd").get(base_capabilities)
vim.lsp.config.ts_ls = require("lsp.configs.ts_ls").get(base_capabilities)

vim.lsp.enable({
  "lua_ls",
  "nixd",
  "ts_ls",
})

lzn.load({
  "lazydev.nvim",
  ft = "lua",
  after = function()
    require("lazydev").setup()
  end,
})
