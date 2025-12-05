require("options")

local lzn = require("lz.n")

lzn.load({
  require("plugins.auto-save"),
  require("plugins.blink-cmp"),
  require("plugins.catppuccin"),
  require("plugins.conform"),
  require("plugins.gitsigns"),
  require("plugins.lualine"),
  require("plugins.neo-tree"),
  require("plugins.noice"),
  require("plugins.nui"),
  require("plugins.nvim-autopairs"),
  require("plugins.nvim-treesitter"),
  require("plugins.nvim-web-devicons"),
  require("plugins.plenary"),
  require("plugins.rainbow-delimiters"),
  require("plugins.smartyank"),
  require("plugins.snacks"),
  require("plugins.which-key"),
})

require("lsp")

vim.cmd.colorscheme("catppuccin")
