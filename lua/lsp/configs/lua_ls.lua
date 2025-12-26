local M = {}

M.get = function(capabilities, on_attach)
  return {
    capabilities = capabilities,
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    on_attach = on_attach,
    root_markers = {
      ".emmyrc.json",
      ".git",
      ".luacheckrc",
      ".luarc.json",
      ".luarc.jsonc",
      ".stylua.toml",
      "selene.toml",
      "selene.yml",
      "stylua.toml",
    },
    settings = {
      Lua = {
        codeLens = { enable = true },
        diagnostics = { globals = { "vim", "Snacks" } },
        hint = { enable = true, semicolon = "Disable" },
        runtime = {
          version = "LuaJIT",
        },
      },
    },
  }
end

return M
