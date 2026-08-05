{ pkgs, ... }:

{
  home.packages = with pkgs; [
    awww
    vicinae
    wl-clipboard
    wleave
  ];
}
