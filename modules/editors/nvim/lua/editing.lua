local surround = require("mini.surround")
local treesj = require("treesj")

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

treesj.setup({ use_default_keymaps = false })

vim.o.virtualedit = "all"
