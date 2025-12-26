return {
  "guess-indent.nvim",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  after = function()
    require("guess-indent").setup({})
  end,
}
