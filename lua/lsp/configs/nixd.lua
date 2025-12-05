vim.lsp.config.nixd = {
  capabilities = require("blink.cmp").get_lsp_capabilities(),
  cmd = { "nixd" },
  filetypes = { "nix" },
  root_markers = { "flake.nix", ".git" },
}
