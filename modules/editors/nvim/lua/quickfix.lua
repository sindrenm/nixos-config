local quicker = require("quicker")

quicker.setup({
  max_filename_width = function()
    return math.floor(math.min(95, vim.o.columns / 4))
  end,
})
