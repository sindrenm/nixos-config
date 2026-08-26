local jump = require("jump")
local smartSplits = require("smart-splits")

-- smart-splits lazily requiring its logger from a vim.system on_exit callback,
-- where the logger's module-level vim.fn.mkdir is illegal (E5560). Load it
-- early here instead to prevent any errors.
require("smart-splits.log")

jump.setup({
  labels = "fdsajkl;" -- home row
})

-- setup() is too strictly annotated; fields are merged
---@diagnostic disable-next-line: missing-fields
smartSplits.setup({
  at_edge = "stop",
  multiplexer_integration = "kitty",
})

vim.keymap.set("n", "<A-h>", smartSplits.move_cursor_left, { desc = "Move to left split or Kitty pane" })
vim.keymap.set("n", "<A-j>", smartSplits.move_cursor_down, { desc = "Move to lower split or Kitty pane" })
vim.keymap.set("n", "<A-k>", smartSplits.move_cursor_up, { desc = "Move to upper split or Kitty pane" })
vim.keymap.set("n", "<A-l>", smartSplits.move_cursor_right, { desc = "Move to right split or Kitty pane" })
