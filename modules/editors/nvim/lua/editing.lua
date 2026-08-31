local surround = require("mini.surround")

surround.setup({
  mappings = {
    add = "<leader>sa",
    delete = "<leader>sd",
    replace = "<leader>sr",

    -- mapping table is merged, empty strings disable
    find = "",
    find_left = "",
    highlight = "",
    suffix_last = "",
    suffix_next = "",
  },
})

vim.o.virtualedit = "all"
