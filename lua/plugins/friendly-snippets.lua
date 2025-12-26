return {
  "friendly-snippets",
  lazy = true,
  after = function()
    require("luasnip.loaders.from_vscode").lazy_load()
  end,
}
