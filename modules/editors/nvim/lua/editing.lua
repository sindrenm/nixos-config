local autopairs = require("nvim-autopairs")
local surround = require("mini.surround")
local tabout = require("tabout")
local treesj = require("treesj")

autopairs.setup()

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

tabout.setup({})

treesj.setup({ use_default_keymaps = false })

vim.o.virtualedit = "all"
