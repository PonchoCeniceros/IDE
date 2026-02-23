return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        "prettier", -- Tu formateador de JSON/JS
        "typescript-language-server", -- El servidor de TS (tsserver/vtsls)
        "stylua", -- Recomendado para tus configs de Lua
        "selene", -- Linter de Lua
      },
      auto_update = true,
      run_on_start = true,
    },
  },
}
