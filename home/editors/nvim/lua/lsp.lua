require("lazydev").setup()

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      -- Injected by the nixCats wrapper
      diagnostics = { globals = { "nixCats" } },
      telemetry = { enable = false },
    },
  },
})

vim.lsp.enable("lua_ls")

vim.diagnostic.config({
  severity_sort = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  virtual_lines = true,
  virtual_text = { prefix = "!", },
})
