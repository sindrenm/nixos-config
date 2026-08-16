local jump = require("jump")
local miniDiff = require("mini.diff")
local whichKey = require("which-key")

local artio = {
  core = require("artio"),
  builtins = require("artio.builtins"),
}

local jj = {
  cmd = require("jj.cmd"),
  annotate = require("jj.annotate"),
  diff = require("jj.diff"),
};

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

-- artio's files picker shells out to its own `findprg`. Point it at the list
-- `:find` uses instead (set in search.lua) so both agree on what a project file
-- is. artio sorts the result itself, so ask findfunc for the unfiltered list.
local findFiles = function()
  -- files() fills in fn/on_close/items itself and merges these over them, so
  -- the fields its Props class marks required are not ours to supply.
  ---@diagnostic disable-next-line: missing-fields
  return artio.builtins.files({
    get_items = function()
      return vim.o.findfunc("", true)
    end,
  })
end

whichKey.add({
  { "<leader>f",  mode = "n", group = "Find" },
  { "<leader>ff", mode = "n", findFiles,                  desc = "Find file" },
  { "<leader>fg", mode = "n", artio.builtins.grep,        desc = "Grep project" },
  { "<leader>f/", mode = "n", artio.builtins.buffergrep,  desc = "Grep current buffer" },
  { "<leader>fb", mode = "n", artio.builtins.buffers,     desc = "Find buffer" },
  { "<leader>fo", mode = "n", artio.builtins.oldfiles,    desc = "Find recent file" },
  { "<leader>fd", mode = "n", artio.builtins.diagnostics, desc = "Find diagnostic" },
  { "<leader>fh", mode = "n", artio.builtins.helptags,    desc = "Find help tag" },
  { "<leader>fq", mode = "n", artio.builtins.quickfix,    desc = "Find in quickfix" },
  { "<leader>fr", mode = "n", artio.core.resume,          desc = "Resume last picker" },
  { "<leader>fp", mode = "n", artio.builtins.builtins,    desc = "Find picker" },
})

local function exportDiffHunks()
  vim.fn.setqflist(miniDiff.export("qf", { scope = "all" }))
  vim.cmd("copen")
end

whichKey.add({
  { "<leader>j",  mode = "n", group = "Jujutsu VCS" },
  { "<leader>jl", mode = "n", jj.cmd.log,              desc = "Log default revset" },
  { "<leader>js", mode = "n", jj.cmd.status,           desc = "Status" },
  { "<leader>ja", mode = "n", jj.annotate.line,        desc = "Annotate current line" },
  { "<leader>jA", mode = "n", jj.annotate.file,        desc = "Annoate whole file" },
  { "<leader>jd", mode = "n", jj.diff.diff_current,    desc = "Diff current against revision" },
  { "<leader>jo", mode = "n", miniDiff.toggle_overlay, desc = "Toggle diff overlay" },
  { "<leader>jq", mode = "n", exportDiffHunks,         desc = "Export diff hunks to quickfix" },
})

local function sort_text_object(reverse)
  vim.o.operatorfunc = function()
    local first = vim.fn.line("'[")
    local last = vim.fn.line("']")

    -- `sort` or `sort!` from `first` to `last` based on `reverse`
    vim.cmd(("%d, %dsort%s"):format(first, last, reverse and "!" or ""))
  end

  return "g@"
end

local function sort_ascending()
  return sort_text_object(false)
end

local function sort_descending()
  return sort_text_object(true)
end

whichKey.add({
  { "gs", mode = "n", expr = true, sort_ascending,  desc = "Sort text object" },
  { "gS", mode = "n", expr = true, sort_descending, desc = "Sort text object (desc)" },
})
