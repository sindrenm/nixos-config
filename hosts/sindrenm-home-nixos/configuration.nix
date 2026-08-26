# Edit this configuration file to define what should be installed on your system. Help is available in the
# configuration.nix(5) man page, on https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
#
# This file is intentionally thin — everything else lives under ../../modules, split by concern and shared across hosts.
# See ../../modules/default.nix for the full module list.

{
  imports = [
    ../../modules
    ./hardware-configuration.nix
    ./xhci-wakeup.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # "light" (default) or "dark"
  home-manager.users.sindre.theming.polarity = "light";

  system.stateVersion = "26.05";
}
