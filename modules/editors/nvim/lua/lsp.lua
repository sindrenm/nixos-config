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

-- Tailwind v4 moved theming out of `tailwind.config.*` and into the stylesheet,
-- so `@theme`, `@plugin` and `@custom-variant` show up in plain CSS. The
-- VS Code CSS server does not know them and flags every one.
vim.lsp.config("cssls", {
  settings = {
    css = { lint = { unknownAtRules = "ignore" } },
    less = { lint = { unknownAtRules = "ignore" } },
    scss = { lint = { unknownAtRules = "ignore" } },
  },
})

vim.lsp.config("jsonls", {
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
      validate = { enable = true },
    },
  },
})

vim.lsp.config("ruff", {
  init_options = {
    settings = {
      hover = { enabled = false },
    },
  },
})

-- Tailwind only scans for class names in places it recognises. These cover the
-- two wrappers `shadcn/ui` generates into every component: `cva()` for variant
-- definitions and `cn()` for the `clsx` + `tailwind-merge` call.
vim.lsp.config("tailwindcss", {
  settings = {
    tailwindCSS = {
      experimental = {
        classRegex = {
          { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
          { "(?:cn|clsx|cx)\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
        },
      },
    },
  },
})

local vtslsInlayHints = {
  enumMemberValues = { enabled = true },
  functionLikeReturnTypes = { enabled = true },
  parameterNames = { enabled = "literals" },
  parameterTypes = { enabled = true },
  propertyDeclarationTypes = { enabled = true },
  variableTypes = { enabled = false },
}

vim.lsp.config("vtsls", {
  settings = {
    javascript = { inlayHints = vtslsInlayHints },
    typescript = {
      inlayHints = vtslsInlayHints,

      -- Vite/tsconfig projects nearly always define a path alias (`~/*` and
      -- friends). Auto-imports should reach for it rather than walking back up
      -- the tree with `../../..`.
      preferences = { importModuleSpecifier = "non-relative" },

      -- oil.nvim forwards renames to the server, so moving a file in the file
      -- manager rewrites the imports that pointed at it.
      updateImportsOnFileMove = { enabled = "always" },
    },

    -- Type-check against the TypeScript the project pins, not the one vtsls
    -- happens to bundle.
    vtsls = { autoUseWorkspaceTsdk = true },
  },

  on_attach = function(client)
    -- ESLint owns layout in these buffers (see formatting.lua). vtsls offers a
    -- formatter too, and two of them makes `vim.lsp.buf.format` stop and ask
    -- which one to use, so take vtsls out of the running.
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
})

vim.lsp.enable("basedpyright")
vim.lsp.enable("bashls")
vim.lsp.enable("cssls")
vim.lsp.enable("eslint")
vim.lsp.enable("html")
vim.lsp.enable("jsonls")
vim.lsp.enable("kotlin_lsp")
vim.lsp.enable("lua_ls")
vim.lsp.enable("marksman")
vim.lsp.enable("nixd")
vim.lsp.enable("nushell")
vim.lsp.enable("roslyn_ls")
vim.lsp.enable("ruff")
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("tailwindcss")
vim.lsp.enable("vtsls")
