local colors = require("themes.catppuccin")

hl.config({
  general = {
    border_size = 2,
    col = {
      active_border = colors.accent,
      inactive_border = colors.crust,
    },
  },
  decoration = {
    rounding = 4,
    inactive_opacity = 0.9,
    shadow = { color = "rgba(" .. colors.crustAlpha .. "ee)" },
    blur = { size = 10 },
  },
  misc = { disable_hyprland_logo = true },
})

-- Animations. Speeds are in tenths of a second.
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })

hl.animation({ leaf = "global", enabled = true, speed = 3, bezier = "default" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 2.5, bezier = "default", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.5, bezier = "default", style = "popin 87%" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 2, bezier = "default", style = "slide" })
