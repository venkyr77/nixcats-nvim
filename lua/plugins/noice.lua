local lzn = require("lz.n")

return {
  "noice.nvim",
  event = "DeferredUIEnter",
  before = function()
    lzn.trigger_load("nui.nvim")
  end,
  after = function()
    require("noice").setup({
      presets = {
        bottom_search = true,
        command_palette = true,
        inc_rename = false,
        long_message_to_split = true,
        lsp_doc_border = false,
      },
    })
  end,
}
