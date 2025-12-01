require("options")

local lzn = require("lz.n")

lzn.load({
  require("plugins.auto-save"),
  require("plugins.catppuccin"),
  require("plugins.neo-tree"),
  require("plugins.nui"),
  require("plugins.nvim-treesitter"),
  require("plugins.plenary"),
  require("plugins.smartyank"),
})

vim.cmd.colorscheme("catppuccin")
