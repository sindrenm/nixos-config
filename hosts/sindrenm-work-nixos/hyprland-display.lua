local laptop_display = "eDP-1"
local lid_marker = os.getenv("XDG_RUNTIME_DIR") .. "/hypr-lid-closed"

local function lid_closed()
  local file = io.open(lid_marker)

  if not file then return false end

  file:close()

  return true
end

local function is_enabled(predicate)
  for _, monitor in ipairs(hl.get_monitors()) do
    if predicate(monitor.name) then return true end
  end

  return false
end

local function has_external()
  return is_enabled(function(name) return name ~= laptop_display end)
end

local function is_laptop_display_enabled()
  return is_enabled(function(name) return name == laptop_display end)
end

local function should_disable_laptop_display()
  return lid_closed() and has_external()
end

local function reload_hyprland()
  hl.dispatch(hl.dsp.exec_cmd("hyprctl reload"))
end

hl.monitor({
  output = laptop_display,
  mode = "preferred",
  position = "auto",
  scale = 4 / 3,
  disabled = should_disable_laptop_display(),
})

hl.bind("switch:on:Lid Switch", function()
  io.open(lid_marker, "w"):close()

  if should_disable_laptop_display() then
    hl.monitor({ output = laptop_display, disabled = true })
  end
end, { locked = true })

hl.bind("switch:off:Lid Switch", function()
  os.remove(lid_marker)

  reload_hyprland() -- already disabled monitors can only be re-enabled with a reload
end, { locked = true })

-- Plugging in a display with the lid closed hands over to it.
hl.on("monitor.added", function()
  if not should_disable_laptop_display() then return end
  if not is_laptop_display_enabled() then return end

  hl.monitor({ output = laptop_display, disabled = true })
end)

-- Unplugging the last external display with the lid closed brings the internal one back.
hl.on("monitor.removed", function()
  if not lid_closed() then return end
  if has_external() then return end
  if is_laptop_display_enabled() then return end

  reload_hyprland()
end)
