local M = {}

M.get = function(capabilities, on_attach)
  return {
    capabilities = capabilities,
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = {
      "javascript",
      "javascript.jsx",
      "javascriptreact",
      "typescript",
      "typescript.tsx",
      "typescriptreact",
    },
    on_attach = on_attach,
    root_markers = {
      ".git",
      "package.json",
      "tsconfig.json",
    },
  }
end

return M
