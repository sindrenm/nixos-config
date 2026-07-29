{ pkgs, ... }:

{
  home.packages = with pkgs; [
    hypridle
    hyprlock
    hyprpolkitagent
  ];
}
