{ pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-hyprland
  ];

  home-manager.users.sindre = {
    home.packages = with pkgs; [
      hyprpolkitagent
    ];

    services.hypridle = {
      enable = true;

      settings = {
        general = {
          lock_cmd = "pidof hyprlock || hyprlock";
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "hyprctl dispatch dpms on";
        };

        listener = {
          timeout = 300; # 5 min
          on-timeout = "loginctl lock-session";
        };
      };
    };

    programs.hyprlock.enable = true;

    catppuccin.hyprlock.flavor = "mocha";
  };
}
