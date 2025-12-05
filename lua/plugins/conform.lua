return {
  "conform.nvim",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  after = function()
    local conform = require("conform")

    conform.setup({
      formatters = {},
      formatters_by_ft = {
        lua = { "stylua" },
        nix = { "alejandra" },
      },
    })

    require("which-key").add({
      { "<leader>c", desc = "+[c]onform(format)" },
      {
        "<leader>cb",
        function()
          conform.format()
        end,
        desc = "[b]uffer",
      },
    })
  end,
}
