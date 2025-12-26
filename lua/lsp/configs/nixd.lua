local M = {}

M.get = function(capabilities)
  return {
    capabilities = capabilities,
    cmd = { "nixd" },
    filetypes = { "nix" },
    root_markers = {
      ".git",
      "flake.nix",
    },
  }
end

return M
