{ pkgs, ... }:

{
  home.packages = with pkgs; [
    android-cli
    android-tools
    androidStudioPackages.canary
    androidStudioPackages.stable
  ];
}
