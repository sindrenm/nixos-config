{ pkgs, ... }:

{
  home.packages = with pkgs; [
    android-cli
    android-tools
  ];
}
