vim.diagnostic.config({
  virtual_lines = {
    format = function(diagnostic)
      return string.format("%s (%s)", diagnostic.message, diagnostic.source)
    end,
  },
})

return {
  "nvim-lint",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  after = function()
    local lint = require("lint")
    lint.linters_by_ft = {
      lua = { "luacheck" },
      nix = { "statix" },
    }
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      callback = function()
        lint.try_lint()
      end,
      group = vim.api.nvim_create_augroup("lint", { clear = true }),
    })
  end,
}
