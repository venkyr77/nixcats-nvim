return {
  "rainbow-delimiters.nvim",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  after = function()
    require("rainbow-delimiters.setup").setup({})
  end,
}
