{
  programs.hyprland.enable = true;

  home-manager.users.sindre =
    {
      pkgs,
      ...
    }:
    {
      home.packages = with pkgs; [
        brightnessctl
      ];

      wayland.windowManager.hyprland = {
        enable = true;
        configType = "lua";

        # NixOS supplies the compositor and matching portal.
        package = null;
        portalPackage = null;

        # Import this before graphical-session.target starts Noctalia, for logind locking.
        systemd.variables = [
          "DISPLAY"
          "HYPRLAND_INSTANCE_SIGNATURE"
          "WAYLAND_DISPLAY"
          "XDG_CURRENT_DESKTOP"
          "XDG_SESSION_ID"
          "XDG_SESSION_TYPE"
        ];

        extraLuaFiles.bindings = ./hyprland/bindings.lua;
        extraLuaFiles.input = ./hyprland/input.lua;
        extraLuaFiles.monitors = ./hyprland/monitors.lua;
        extraLuaFiles.noctalia = ./hyprland/noctalia.lua;
        extraLuaFiles.theming = ./hyprland/theming.lua;
        extraLuaFiles.windows = ./hyprland/windows.lua;
      };
    };
}
