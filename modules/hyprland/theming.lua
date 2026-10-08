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
