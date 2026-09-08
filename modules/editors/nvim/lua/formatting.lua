local conform = require("conform")

conform.setup({
  formatters_by_ft = {
    markdown = { "prettier" },
  },
})

-- `gq` (and anything else going through 'formatexpr') formats with conform
-- where a formatter is configured. Conform hands the buffer back to Neovim's
-- built-in formatting for filetypes it has nothing for.
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
