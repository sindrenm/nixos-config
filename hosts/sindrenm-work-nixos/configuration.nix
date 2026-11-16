{ lib, ... }:

{
  imports = [
    ../../modules
    ../common/laptop-display.nix
    ../common/nvidia-gpu.nix
    ../common/office-printers.nix
    ./display.nix
    ./hardware-configuration.nix
    ./laptop.nix
    ./nvidia-prime.nix
  ];

  # Limine keeps the boot order.
  boot.loader.efi.canTouchEfiVariables = lib.mkForce false;

  # "light" (default) or "dark"
  home-manager.users.sindre.theming.polarity = "light";

  system.stateVersion = "26.05";
}
