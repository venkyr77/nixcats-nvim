return {
  "conform.nvim",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  after = function()
    require("conform").setup({})
  end,
}
