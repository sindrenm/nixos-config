local oil = require("oil")
local oilLspDiagnostics = require("oil-lsp-diagnostics")

oil.setup({
  delete_to_trash = true,
  skip_confirm_for_simple_edits = true,
})

oilLspDiagnostics.setup()
