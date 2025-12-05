local function is_path_source(ctx)
  return ctx.source_name == "Path"
end

local function get_devicon(ctx)
  return require("nvim-web-devicons").get_icon(ctx.label)
end

local lzn = require("lz.n")

return {
  "blink.cmp",
  before = function()
    lzn.trigger_load("nvim-web-devicons")
    lzn.trigger_load("lspkind.nvim")
  end,
  event = "InsertEnter",
  after = function()
    require("blink.cmp").setup({
      completion = {
        list = {
          selection = { auto_insert = false, preselect = false },
        },
        menu = {
          draw = {
            columns = {
              { "label", "label_description", gap = 1 },
              { "kind_icon", "kind", gap = 1 },
              { "source_name" },
            },
            components = {
              kind_icon = {
                highlight = function(ctx)
                  if is_path_source(ctx) then
                    local _, hl = get_devicon(ctx)
                    if hl then
                      return hl
                    end
                  end
                  return ctx.kind_hl
                end,
                text = function(ctx)
                  local icon = ctx.kind_icon
                  if is_path_source(ctx) then
                    icon = get_devicon(ctx) or icon
                  else
                    icon = require("lspkind").symbolic(ctx.kind, { mode = "symbol" })
                  end
                  return icon .. ctx.icon_gap
                end,
              },
            },
          },
        },
      },
      keymap = { preset = "enter" },
      signature = { enabled = true },
    })
  end,
}
