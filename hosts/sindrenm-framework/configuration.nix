{ nixos-hardware, ... }:

{
  imports = [
    # Framework Laptop 13 Pro (Intel Core Ultra Series 3 / Panther Lake).
    nixos-hardware.nixosModules.framework-intel-core-ultra-series3

    ../../modules
    ../common/laptop-display.nix
    ../common/office-printers.nix
    ./display.nix
    ./filesystems.nix
    ./hardware-configuration.nix
    ./laptop.nix
  ];

  # "light" (default) or "dark"
  home-manager.users.sindre.theming.polarity = "light";

  system.stateVersion = "26.05";
}
