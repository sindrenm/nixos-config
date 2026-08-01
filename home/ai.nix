{ pkgs, ... }:

{
  home.packages = with pkgs; [
    antigravity-cli
    antigravity-ide
    claude-code
    claude-desktop-fhs
    codex
  ];
}
