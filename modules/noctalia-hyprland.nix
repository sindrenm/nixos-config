{
  config,
  lib,
  pkgs,
  ...
}:

{
  home-manager.users.sindre = lib.mkIf config.programs.hyprland.enable {
    # Right after the workspaces widget, which hides Hyprland's special workspaces.
    noctalia.bar.startGroup = lib.mkOrder 600 [ "special-workspaces" ];

    home.packages = [
      pkgs.socat # needed by special-workspaces
    ];

    programs.noctalia.settings = {
      plugins.enabled = [
        "maddingo/hypr-layout-switcher"
        "jamesfeeder/special-workspaces"
      ];

      widget.hypr-layout.type = "maddingo/hypr-layout-switcher:toggle";

      widget.special-workspaces = {
        type = "jamesfeeder/special-workspaces:special-workspaces";

        # Only show a pill while a special workspace is open.
        hide_inactive = true;
      };

      bar.main.center = lib.mkAfter [ "hypr-layout" ];
    };
  };
}
