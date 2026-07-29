{ pkgs, ... }:

{
  home.packages = with pkgs; [
    kotlin-language-server
    lua-language-server
    nixd
    rust-analyzer
  ];
}
