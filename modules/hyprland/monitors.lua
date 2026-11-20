hl.monitor({
  output = "",
  mode = "preferred",
  position = "auto",
  scale = 1,
})

-- Work desk. Matched by description rather than connector so the rule follows the monitor across ports and docks.
hl.monitor({
  output = "desc:HP Inc. HP Z38c 6CM12003SZ",
  mode = "3840x1600@59.99",
  position = "1920x0",
  scale = 1,
})
