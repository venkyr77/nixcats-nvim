return {
  "snacks.nvim",
  lazy = false,
  after = function()
    require("snacks").setup({
      indent = {
        enabled = true,
        indent = {
          hl = {
            "RainbowRed",
            "RainbowYellow",
            "RainbowBlue",
            "RainbowOrange",
            "RainbowGreen",
            "RainbowViolet",
            "RainbowCyan",
          },
        },
        scope = { enabled = false },
      },
    })
  end,
}
