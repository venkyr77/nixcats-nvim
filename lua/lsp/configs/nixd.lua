local M = {}

M.get = function(capabilities, on_attach)
  return {
    capabilities = capabilities,
    cmd = { "nixd" },
    filetypes = { "nix" },
    on_attach = on_attach,
    root_markers = {
      ".git",
      "flake.nix",
    },
  }
end

return M
