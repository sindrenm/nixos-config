# Edit this configuration file to define what should be installed on your
# system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
#
# This file is intentionally thin — everything else lives under
# ./configuration/, split by concern. See ./configuration/default.nix for the
# full module list.

{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./configuration
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "26.05";
}
