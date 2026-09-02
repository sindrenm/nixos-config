local fidget = require("fidget")
local lazydev = require("lazydev")

fidget.setup({
  notification = {
    window = { align = "top" },
  },
})

lazydev.setup()

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      -- Injected by the nixCats wrapper
      diagnostics = { globals = { "nixCats" } },
      telemetry = { enable = false },
    },
  },
})

vim.lsp.config("nixd", {
  settings = {
    nixd = {
      formatting = { command = { "nixfmt" } },
    },
  },
})

vim.lsp.enable("bashls")
vim.lsp.enable("kotlin_lsp")
vim.lsp.enable("lua_ls")
vim.lsp.enable("marksman")
vim.lsp.enable("nixd")
vim.lsp.enable("roslyn_ls")

vim.diagnostic.config({
  severity_sort = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  virtual_lines = true,
  virtual_text = { prefix = "!", },
})
