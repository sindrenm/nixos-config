{ pkgs, ... }:

{
  home.packages = with pkgs; [
    carapace
    starship
  ];
}
