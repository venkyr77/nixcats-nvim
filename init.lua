local lzn = require("lz.n")

lzn.load({
  { "nui.nvim", lazy = true },
  { "plenary.nvim", lazy = true },
  {
    "neo-tree.nvim",
    lazy = false,
    before = function()
      lzn.trigger_load("nui.nvim")
      lzn.trigger_load("plenary.nvim")
    end,
    after = function()
      require("neo-tree").setup({})
    end,
  },
})

require("nvim-treesitter.configs").setup({
  highlight = {
    enable = true,
  },
})
