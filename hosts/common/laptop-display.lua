-- Built-in laptop display handling shared by the laptops: hands over to an external display when the lid is closed,
-- and brings the internal display back when the lid opens or the last external display is unplugged. SUPER + P toggles
-- mirroring the internal display to all external displays, e.g. for presenting in meeting rooms.
--
-- Not auto-loaded. Each host calls `require("laptop-display").setup({ scale = … })` from its own display file.

local M = {}

local laptop_display = "eDP-1"
local lid_marker = os.getenv("XDG_RUNTIME_DIR") .. "/hypr-lid-closed"

local function lid_closed()
  local file = io.open(lid_marker)

  if not file then return false end

  file:close()

  return true
end

-- Mirrored monitors are left out of hl.get_monitors() unless asked for with `all`.
local function external_monitors()
  local monitors = {}

  for _, monitor in ipairs(hl.get_monitors({ all = true })) do
    if monitor.name ~= laptop_display and monitor.enabled then table.insert(monitors, monitor) end
  end

  return monitors
end

local function has_external()
  return #external_monitors() > 0
end

local function is_mirroring()
  for _, monitor in ipairs(external_monitors()) do
    if monitor.is_mirror then return true end
  end

  return false
end

local function is_laptop_display_enabled()
  for _, monitor in ipairs(hl.get_monitors()) do
    if monitor.name == laptop_display then return true end
  end

  return false
end

local function should_disable_laptop_display()
  return lid_closed() and has_external()
end

local function reload_hyprland()
  hl.dispatch(hl.dsp.exec_cmd("hyprctl reload"))
end

-- Each external monitor's setup from before mirroring, by output name, so stopping can put it back.
local unmirrored_specs = {}

local function snapshot(monitor)
  return {
    output = monitor.name,
    mode = string.format("%dx%d@%.2f", monitor.width, monitor.height, monitor.refresh_rate),
    position = monitor.x .. "x" .. monitor.y,
    scale = monitor.scale,
    transform = monitor.transform,
  }
end

-- Like Windows' Win + P (“Project”).
local function toggle_mirroring()
  if is_mirroring() then
    for _, monitor in ipairs(external_monitors()) do
      local spec = unmirrored_specs[monitor.name]
        or { output = monitor.name, mode = "preferred", position = "auto", scale = 1 }

      spec.mirror = "" -- clears the mirror in place

      hl.monitor(spec)
    end

    unmirrored_specs = {}

    return
  end

  if not is_laptop_display_enabled() then return end

  for _, monitor in ipairs(external_monitors()) do
    unmirrored_specs[monitor.name] = snapshot(monitor)

    hl.monitor({
      output = monitor.name,
      mode = "preferred",
      position = "auto",
      scale = 1,
      mirror = laptop_display,
    })
  end
end

--- @param opts { scale: number, position: string? }
function M.setup(opts)
  hl.monitor({
    output = laptop_display,
    mode = "preferred",
    position = opts.position or "auto",
    scale = opts.scale,
    disabled = should_disable_laptop_display(),
  })

  hl.bind("SUPER + P", toggle_mirroring)

  hl.bind("switch:on:Lid Switch", function()
    io.open(lid_marker, "w"):close()

    if not should_disable_laptop_display() then return end

    if is_mirroring() then
      reload_hyprland() -- external displays can't keep mirroring a disabled display
    else
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
end

return M
