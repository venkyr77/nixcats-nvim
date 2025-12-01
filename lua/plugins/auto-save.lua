return {
  "auto-save.nvim",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  after = function()
    require("auto-save").setup({ debounce_delay = 100 })
  end,
}
