{ pkgs, ... }:

{
  home.packages = with pkgs; [
    mpv
    stremio-linux-shell
  ];
}
