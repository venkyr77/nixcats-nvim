return {
  "gitsigns.nvim",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  after = function()
    require("gitsigns").setup({})
  end,
}
