local conform = require("conform")

conform.setup({
  formatters_by_ft = {
    kotlin = { "ktfmt" },
    markdown = { "prettier" },
    nu = { "nufmt" },
    python = { "ruff_organize_imports", "ruff_format" },
  },
  formatters = {
    ktfmt = {
      prepend_args = { "--google-style" },
    },
  },
})

-- `gq` (and anything else going through 'formatexpr') formats with conform
-- where a formatter is configured. Conform hands the buffer back to Neovim's
-- built-in formatting for filetypes it has nothing for.
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
