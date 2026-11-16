{
  home-manager.users.sindre.wayland.windowManager.mango.settings.monitor_rule = [
    "name:^eDP-1$,scale:1.5"
  ];

  home-manager.users.sindre.wayland.windowManager.hyprland.extraLuaFiles.display =
    ./hyprland-display.lua;
}
