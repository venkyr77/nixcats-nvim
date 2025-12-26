local M = {}

M.get = function(capabilities)
  return {
    capabilities = capabilities,
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
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
        hint = { enable = true, semicolon = "Disable" },
        runtime = {
          version = "LuaJIT",
        },
      },
    },
  }
end

return M
