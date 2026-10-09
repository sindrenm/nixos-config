local exec = hl.dsp.exec_cmd

hl.bind("SUPER + Return", exec("kitty"))
hl.bind("SUPER + Q", hl.dsp.window.close())
hl.bind("SUPER + Space", exec("vicinae toggle"))
hl.bind("SUPER + E", exec("nautilus"))
hl.bind("SUPER + Escape", exec("loginctl lock-session"))
hl.bind("SUPER + SHIFT + Escape", exec("systemctl suspend"))
hl.bind("CTRL + ALT + Delete", exec("noctalia msg panel-toggle session"))
hl.bind("SUPER + SHIFT + R", exec("hyprctl reload"))

for key, direction in pairs({ H = "left", J = "down", K = "up", L = "right" }) do
  hl.bind("SUPER + " .. key, hl.dsp.focus({ direction = direction }))
  hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.swap({ direction = direction }))
end

hl.bind("SUPER + SHIFT + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

for i = 1, 9 do
  hl.bind("SUPER + " .. i, hl.dsp.focus({ workspace = i }))
  hl.bind("SUPER + SHIFT + " .. i, hl.dsp.window.move({ workspace = i, follow = true }))
end

hl.bind("SUPER + S", hl.dsp.workspace.toggle_special("scratchpad"))
hl.bind("SUPER + SHIFT + S", hl.dsp.window.move({ workspace = "special:scratchpad", follow = false }))

for key, command in pairs({
  XF86AudioRaiseVolume = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+",
  XF86AudioLowerVolume = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-",
  XF86AudioMute = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle",
  XF86AudioMicMute = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle",
  XF86MonBrightnessUp = "brightnessctl s 10%+",
  XF86MonBrightnessDown = "brightnessctl s 10%-",
  XF86AudioPlay = "playerctl play-pause",
  XF86AudioPause = "playerctl play-pause",
  XF86AudioForward = "playerctl position 10+",
  XF86AudioRewind = "playerctl position 10-",
  XF86AudioNext = "playerctl next",
  XF86AudioPrev = "playerctl previous",
}) do
  hl.bind(key, exec(command), { locked = true })
end

hl.bind("Print", exec("noctalia msg screenshot-region"))
hl.bind("CTRL + Print", exec("~/.config/hypr/scripts/screenshot-window.nu"))
hl.bind("ALT + Print", exec("noctalia msg screenshot-fullscreen monitor"))

-- Per-workspace tiling layout, mirroring mango's SUPER+N layout mode. Any key below leaves the mode again.
local layouts = { "dwindle", "master", "scrolling", "monocle" }

local function active_workspace()
  return hl.get_active_special_workspace() or hl.get_active_workspace()
end

local function set_layout(layout)
  local workspace = active_workspace()

  if not workspace then return end

  hl.workspace_rule({ workspace = workspace.special and workspace.name or tostring(workspace.id), layout = layout })
end

local function cycle_layout()
  local workspace = active_workspace()
  local current = workspace and workspace.tiled_layout

  for i, layout in ipairs(layouts) do
    if layout == current then return set_layout(layouts[i % #layouts + 1]) end
  end

  set_layout(layouts[1])
end

hl.bind("SUPER + N", hl.dsp.submap("layout"))

hl.define_submap("layout", "reset", function()
  hl.bind("N", cycle_layout)
  hl.bind("D", function() set_layout("dwindle") end)
  hl.bind("M", function() set_layout("master") end)
  hl.bind("S", function() set_layout("scrolling") end)
  hl.bind("O", function() set_layout("monocle") end)
  hl.bind("Escape", hl.dsp.submap("reset"))
  hl.bind("Return", hl.dsp.submap("reset"))
end)
