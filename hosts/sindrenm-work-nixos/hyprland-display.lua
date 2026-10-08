local lid_marker = os.getenv("XDG_RUNTIME_DIR") .. "/hypr-lid-closed"

local function lid_closed()
  local file = io.open(lid_marker)

  if not file then return false end

  file:close()

  return true
end

hl.monitor({
  output = "eDP-1",
  mode = "preferred",
  position = "auto",
  scale = 4 / 3,
  disabled = lid_closed(),
})

hl.bind("switch:on:Lid Switch", function()
  io.open(lid_marker, "w"):close()
  hl.monitor({ output = "eDP-1", disabled = true })
end, { locked = true })

hl.bind("switch:off:Lid Switch", function()
  os.remove(lid_marker)

  -- A new monitor rule doesn't wake an already disabled output, but a reload
  -- re-applies all rules.
  hl.dispatch(hl.dsp.exec_cmd("hyprctl reload"))
end, { locked = true })
