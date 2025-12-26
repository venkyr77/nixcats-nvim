local lzn = require("lz.n")

lzn.trigger_load("blink.cmp")

local base_capabilities = require("blink.cmp").get_lsp_capabilities()

local default_on_attach = function(_, buffer)
  local picker_opts = {
    layout = { fullscreen = true },
  }

  local jump_to_diagnostic = function(count)
    vim.diagnostic.jump({
      count = count,
      float = false,
    })
  end

  require("which-key").add({
    {
      "<leader>g",
      buffer = buffer,
      desc = "+[g]oto(lsp)",
      icon = " ",
    },
    {
      "<leader>gd",
      buffer = buffer,
      function()
        Snacks.picker.lsp_definitions(picker_opts)
      end,
      desc = "[d]efinitions",
    },
    {
      "<leader>gD",
      buffer = buffer,
      function()
        Snacks.picker.lsp_declarations(picker_opts)
      end,
      desc = "[D]eclarations",
    },
    {
      "<leader>gi",
      buffer = buffer,
      function()
        Snacks.picker.lsp_implementations(picker_opts)
      end,
      desc = "[i]mplementations",
    },
    {
      "<leader>gr",
      buffer = buffer,
      function()
        Snacks.picker.lsp_references(picker_opts)
      end,
      desc = "[r]eferences",
    },
    {
      "<leader>gt",
      buffer = buffer,
      function()
        Snacks.picker.lsp_type_definitions(picker_opts)
      end,
      desc = "[t]ype definitions",
    },
    {
      "<leader>l",
      buffer = buffer,
      desc = "+[l]sp",
    },
    {
      "<leader>la",
      buffer = buffer,
      function()
        vim.lsp.buf.code_action()
      end,
      desc = "code [a]ction",
    },
    {
      "<leader>ld",
      buffer = buffer,
      desc = "+[d]iagnostics",
    },
    {
      "<leader>ldn",
      buffer = buffer,
      function()
        jump_to_diagnostic(1)
      end,
      desc = "[n]ext",
    },
    {
      "<leader>ldp",
      buffer = buffer,
      function()
        jump_to_diagnostic(-1)
      end,
      desc = "[p]rev",
    },
    {
      "<leader>ldt",
      buffer = buffer,
      function()
        vim.diagnostic.enable(not vim.diagnostic.is_enabled())
      end,
      desc = "[t]oggle",
      icon = " ",
    },
    {
      "<leader>lr",
      buffer = buffer,
      function()
        vim.lsp.buf.rename()
      end,
      desc = "[r]ename",
    },
  })
end

vim.lsp.config.lua_ls = require("lsp.configs.lua_ls").get(base_capabilities, default_on_attach)
vim.lsp.config.nixd = require("lsp.configs.nixd").get(base_capabilities, default_on_attach)
vim.lsp.config.ts_ls = require("lsp.configs.ts_ls").get(base_capabilities, default_on_attach)

vim.lsp.enable({
  "lua_ls",
  "nixd",
  "ts_ls",
})

lzn.load({
  "lazydev.nvim",
  ft = "lua",
  after = function()
    require("lazydev").setup()
  end,
})
