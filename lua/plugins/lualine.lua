return {
  "lualine.nvim",
  event = "DeferredUIEnter",
  after = function()
    require("lualine").setup({
      extensions = {
        "neo-tree",
      },
    })
  end,
}
