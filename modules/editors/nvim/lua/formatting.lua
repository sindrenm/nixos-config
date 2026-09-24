local conform = require("conform")

local prettierConfigFiles = {
  ".prettierrc",
  ".prettierrc.cjs",
  ".prettierrc.js",
  ".prettierrc.json",
  ".prettierrc.json5",
  ".prettierrc.mjs",
  ".prettierrc.toml",
  ".prettierrc.yaml",
  ".prettierrc.yml",
  "prettier.config.cjs",
  "prettier.config.js",
  "prettier.config.mjs",
  "prettier.config.ts",
}

-- Web projects disagree about who owns layout. Most hand it to Prettier, but
-- some lint it with ESLint's `@stylistic` rules instead, and running Prettier
-- in one of those means every save fights the linter. So only claim the buffer
-- when the project actually asks for Prettier; otherwise return nothing and let
-- `lsp_format = "fallback"` below hand it to the ESLint language server, which
-- applies the same fixes `eslint --fix` would.
local function prettierIfConfigured(bufnr)
  local from = vim.api.nvim_buf_get_name(bufnr)

  if vim.fs.find(prettierConfigFiles, { path = from, upward = true })[1] then
    return { "prettier" }
  end

  -- Prettier also reads a `prettier` key out of package.json.
  for _, packageJson in ipairs(vim.fs.find("package.json", { path = from, upward = true, limit = math.huge })) do
    local ok, contents = pcall(vim.json.decode, table.concat(vim.fn.readfile(packageJson), "\n"))

    if ok and type(contents) == "table" and contents.prettier ~= nil then
      return { "prettier" }
    end
  end

  return {}
end

conform.setup({
  formatters_by_ft = {
    kotlin = { "ktfmt" },
    css = { "prettier" },
    html = { "prettier" },
    json = { "prettier" },
    jsonc = { "prettier" },
    markdown = { "prettier" },
    yaml = { "prettier" },

    javascript = prettierIfConfigured,
    javascriptreact = prettierIfConfigured,
    typescript = prettierIfConfigured,
    typescriptreact = prettierIfConfigured,

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
