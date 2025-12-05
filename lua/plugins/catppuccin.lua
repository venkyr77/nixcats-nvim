return {
  "catppuccin.nvim",
  colorscheme = "catppuccin",
  after = function()
    require("catppuccin").setup({
      custom_highlights = function(colors)
        return {
          RainbowBlue = { blend = 0, fg = colors.blue },
          RainbowCyan = { blend = 0, fg = colors.teal },
          RainbowGreen = { blend = 0, fg = colors.green },
          RainbowOrange = { blend = 0, fg = colors.peach },
          RainbowRed = { blend = 0, fg = colors.red },
          RainbowViolet = { blend = 0, fg = colors.mauve },
          RainbowYellow = { blend = 0, fg = colors.yellow },
        }
      end,
    })
  end,
}
