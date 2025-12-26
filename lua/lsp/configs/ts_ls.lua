local M = {}

M.get = function(capabilities)
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
    root_markers = {
      ".git",
      "package.json",
      "tsconfig.json",
    },
  }
end

return M
