{ pkgs, ... }:

{
  home.packages = with pkgs; [
    awww
    wl-clipboard
    wleave
  ];
}
