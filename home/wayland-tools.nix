{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ashell
    awww
    vicinae
    wl-clipboard
    wleave
  ];
}
