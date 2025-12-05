return {
  "lspkind.nvim",
  lazy = true,
  after = function()
    require("lspkind").setup()
  end,
}
