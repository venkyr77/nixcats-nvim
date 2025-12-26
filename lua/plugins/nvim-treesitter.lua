return {
  "nvim-treesitter",
  lazy = false,
  after = function()
    require("nvim-treesitter.configs").setup({
      auto_install = false,
      ensure_installed = {},
      highlight = {
        additional_vim_regex_highlighting = false,
        enable = true,
      },
      indent = {
        enable = true,
      },
      sync_install = false,
    })
  end,
}
