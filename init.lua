local lzn = require("lz.n")

lzn.load({
  { "nui.nvim", lazy = true },
  { "plenary.nvim", lazy = true },
  {
    "catppuccin.nvim",
    colorscheme = "catppuccin",
    after = function()
      require("plugins.catppuccin").setup()
    end,
  },
  {
    "neo-tree.nvim",
    lazy = false,
    before = function()
      lzn.trigger_load("nui.nvim")
      lzn.trigger_load("plenary.nvim")
    end,
    after = function()
      require("plugins.neo-tree").setup()
    end,
  },
})

require("plugins.nvim-treesitter").setup()

vim.cmd.colorscheme("catppuccin")
