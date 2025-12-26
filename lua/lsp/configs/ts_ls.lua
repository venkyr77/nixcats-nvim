vim.lsp.config.ts_ls = {
  capabilities = require("blink.cmp").get_lsp_capabilities(),
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  root_markers = {
    "flake.nix",
    ".git",
  },
}
