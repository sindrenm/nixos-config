{ lib, ... }:

{
  imports = [
    ../../modules
    ./hardware-configuration.nix
    ./laptop.nix
    ./nvidia-prime.nix
  ];

  # Limine keeps the boot order.
  boot.loader.efi.canTouchEfiVariables = lib.mkForce false;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # "light" (default) or "dark"
  home-manager.users.sindre.theming.polarity = "light";

  system.stateVersion = "26.05";
}
