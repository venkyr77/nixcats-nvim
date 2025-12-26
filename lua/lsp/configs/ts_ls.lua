vim.lsp.config.ts_ls = {
  capabilities = require("blink.cmp").get_lsp_capabilities(),
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = {
    "javascript",
    "javascript.jsx",
    "javascriptreact",
    "typescript",
    "typescript.tsx",
    "typescriptreact",
  },
  root_markers = {
    ".git",
    "package.json",
    "tsconfig.json",
  },
}
