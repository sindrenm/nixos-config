local catppuccin = require("catppuccin")
local icons = require("mini.icons")
local ui2 = require("vim._core.ui2")

catppuccin.setup({
  float = {
    transparent = true,
    solid = false,
  },
})

vim.cmd.colorscheme("catppuccin")

icons.setup()

ui2.enable({
  enable = true,
  msg = {
    targets = "msg", -- or "msg" for floating window
    cmd = { height = 0.5 },
    msg = { height = 0.5, timeout = 5000 },
    pager = { height = 0.5 },
  },
})
