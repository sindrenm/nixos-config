local fidget = require("fidget")
local lazydev = require("lazydev")
local tinyInlineDiagnostic = require("tiny-inline-diagnostic")

fidget.setup({
  notification = {
    window = { align = "top" },
  },
})

lazydev.setup()

tinyInlineDiagnostic.setup({
  options = {
    multilines = {
      enabled = true,
      tabstop = 2,
    },
  },
})

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
