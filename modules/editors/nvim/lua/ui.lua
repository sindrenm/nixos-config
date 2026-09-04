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

-- ui2 reads the message timeout and the cmdline max height from 'messagesopt'.
vim.o.messagesopt = vim.o.messagesopt .. ",maxheight:50,timeout:5000"

ui2.enable({
  enable = true,
  msg = {
    targets = "msg", -- or "msg" for floating window
    msg = { height = 0.5 },
    pager = { height = 0.5 },
  },
})
