{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    cantarell-fonts
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
  ];
}
