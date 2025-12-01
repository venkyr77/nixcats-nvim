local lzn = require("lz.n")

lzn.load({
  require("plugins.catppuccin"),
  require("plugins.neo-tree"),
  require("plugins.nui"),
  require("plugins.nvim-treesitter"),
  require("plugins.plenary"),
})

vim.cmd.colorscheme("catppuccin")
