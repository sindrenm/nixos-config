local jj = require("jj")
local miniDiff = require("mini.diff")

jj.setup({})
miniDiff.setup({
  mappings = {
    apply = "", -- disable, as it's not applicable to `jj`
    textobject = "ih", -- “inside hunk” mnemonic
    reset = "<leader>jr",
    goto_first = "[H",
    goto_prev = "[h",
    goto_next = "]h",
    goto_last = "]H",
  },
  view = {
    style = "number",
  },
})
