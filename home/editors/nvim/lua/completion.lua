local blink = require("blink.cmp")

blink.setup({
  fuzzy = { implementation = "rust" },
  keymap = { preset = "default" },
  signature = { enabled = true },
  sources = {
    default = {
      "conventional_commits",
      "lsp",
      "path",
      "snippets",
      "buffer",
    },
    providers = {
      conventional_commits = {
        name = "Conventional Commits",
        module = "blink-cmp-conventional-commits",
        enabled = function()
          return vim.bo.filetype == "jjdescription" or vim.bo.filetype == "gitcommit"
        end,
      },
    },
  },
})
