local jump = require("jump")
local whichKey = require("which-key")

local jj = {
  cmd = require("jj.cmd"),
  annotate = require("jj.annotate"),
  diff = require("jj.diff"),
};

vim.g.mapleader = " "

whichKey.setup({ preset = "modern" });

whichKey.add({
  { "<leader>l",  mode = { "n", "x", "o" }, group = "Language Server" },
  { "<leader>ld", mode = "n",               vim.lsp.buf.definition,     desc = "Go to definition" },
  { "<leader>li", mode = "n",               vim.lsp.buf.implementation, desc = "List implementations" },
  { "<leader>lr", mode = "n",               vim.lsp.buf.references,     desc = "List references" },
  { "<leader>ln", mode = "n",               vim.lsp.buf.rename,         desc = "Rename symbol" },
  { "<leader>la", mode = { "n", "x", "o" }, vim.lsp.buf.code_action,    desc = "Code action" },
  { "<leader>lf", mode = "n",               vim.lsp.buf.format,         desc = "Format buffer" },
})

local diagnosticOverview = function()
  vim.diagnostic.setqflist()
  vim.cmd("copen")
end

whichKey.add({
  { "<leader>d", mode = "n", vim.diagnostic.open_float, desc = "Open diagnostic float" },
  { "<leader>D", mode = "n", diagnosticOverview,        desc = "Open diagnostic overview" },
})

whichKey.add({
  { "s", mode = { "n", "x", "o" }, jump.start, desc = "Jump to match" },
})

whichKey.add({
  { "<leader>j",  mode = "n", group = "Jujutsu VCS" },
  { "<leader>jl", mode = "n", jj.cmd.log,           desc = "Log default revset" },
  { "<leader>js", mode = "n", jj.cmd.status,        desc = "Status" },
  { "<leader>ja", mode = "n", jj.annotate.line,     desc = "Annotate current line" },
  { "<leader>jA", mode = "n", jj.annotate.file,     desc = "Annoate whole file" },
  { "<leader>jd", mode = "n", jj.diff.diff_current, desc = "Diff current against revision" },
})
