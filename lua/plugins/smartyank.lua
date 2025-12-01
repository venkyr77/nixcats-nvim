return {
  "smartyank.nvim",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  after = function()
    require("smartyank").setup({ osc52 = { ssh_only = false } })
  end,
}
