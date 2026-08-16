local toggleterm = require("toggleterm")

toggleterm.setup({
  open_mapping = [[<C-\>]],
  direction = "float",
  float_opts = {
    border = "rounded",
    title_pos = "right",
  },
})
