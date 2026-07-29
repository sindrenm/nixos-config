{ pkgs, ... }:

{
  home.packages = with pkgs; [
    hypridle
    hyprlock
    hyprpaper
    hyprpicker
    hyprshot
    wlogout
  ];
}
