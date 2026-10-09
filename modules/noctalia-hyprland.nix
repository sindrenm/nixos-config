{ config, lib, ... }:

{
  home-manager.users.sindre = lib.mkIf config.programs.hyprland.enable {
    programs.noctalia.settings = {
      plugins.enabled = [
        "maddingo/hypr-layout-switcher"
      ];

      widget.hypr-layout.type = "maddingo/hypr-layout-switcher:toggle";

      bar.main.center = lib.mkAfter [ "hypr-layout" ];
    };
  };
}
