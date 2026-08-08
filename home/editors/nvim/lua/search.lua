local artio = require("artio")

local function project_files()
  local result = vim
      .system({ "fd" }, { text = true })
      :wait()

  if result.code ~= 0 then
    return {}
  end

  return vim.split(result.stdout, "\n", { trimempty = true })
end

vim.o.findfunc = function(cmdarg, _)
  local files = project_files()

  if cmdarg == "" then
    return files
  end

  return vim.fn.matchfuzzy(files, cmdarg)
end

vim.o.grepprg = "rg --vimgrep --smart-case"
vim.o.grepformat = "%f:%l:%c:%m"

-- :grep populates the quickfix list but does not open it.
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  group = vim.api.nvim_create_augroup("grep-quickfix-auto-open", { clear = true }),
  pattern = { "grep", "grepadd" },
  command = "cwindow",
})

-- `artio.config` declares opts/win/mappings as required, but setup() merges
-- whatever it gets over the defaults, so a partial table is the intended usage.
---@diagnostic disable-next-line: missing-fields
artio.setup({
  mappings = {
    ["<c-n>"] = "down",
    ["<c-p>"] = "up",
    ["<cr>"]  = "accept",
    ["<esc>"] = "cancel",
    ["<c-space>"] = "mark",
    ["<m-l>"] = "togglelive",
    ["<m-p>"] = "togglepreview",
    ["<c-q>"] = "setqflist",
    ["<m-q>"] = "setqflistmark",
  },
})

vim.ui.select = artio.select
