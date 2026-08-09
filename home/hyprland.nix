{ pkgs, ... }:

{
  home.packages = with pkgs; [
    hyprpolkitagent
    hyprexpo
  ];

  # Stable path for the dotfiles-managed Lua config to hl.plugin.load(), since
  # the nix store path changes on every rebuild.
  home.file.".local/lib/hypr-plugins/hyprexpo.so".source = "${pkgs.hyprexpo}/lib/libhyprexpo.so";

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
}
