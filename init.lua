require("options")

vim.keymap.set("n", "<Esc>", "<CMD>nohlsearch<CR>")

local lzn = require("lz.n")

lzn.load({
  require("plugins.which-key"),
})

lzn.load({
  require("plugins.snacks"),
})

lzn.load({
  require("plugins.auto-save"),
  require("plugins.blink-cmp"),
  require("plugins.catppuccin"),
  require("plugins.conform"),
  require("plugins.friendly-snippets"),
  require("plugins.gitsigns"),
  require("plugins.guess-indent"),
  require("plugins.lspkind"),
  require("plugins.lualine"),
  require("plugins.luasnip"),
  require("plugins.neo-tree"),
  require("plugins.noice"),
  require("plugins.nui"),
  require("plugins.nvim-autopairs"),
  require("plugins.nvim-treesitter"),
  require("plugins.nvim-web-devicons"),
  require("plugins.plenary"),
  require("plugins.rainbow-delimiters"),
  require("plugins.smartyank"),
  require("plugins.todo-comments"),
})

require("lsp")

vim.cmd.colorscheme("catppuccin")
