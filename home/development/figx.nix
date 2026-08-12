{ pkgs, ... }:

{
  home.packages = with pkgs; [
    figx
  ];
}
