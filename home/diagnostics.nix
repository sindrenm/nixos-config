{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gpu-viewer
    mesa-demos
  ];
}
