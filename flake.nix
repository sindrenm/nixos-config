{
  description = "My NixOS Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    { nixpkgs, ... }:
    {
      nixosConfigurations = {
        home = nixpkgs.lib.nixosSystem {
          modules = [
            ./hosts/home/configuration.nix
            ./modules/common.nix
            ./modules/nvidia.nix

            # Users
            ./users/sindre.nix

            # Services
            ./modules/services/desktop-managers/gnome.nix
            ./modules/services/display-managers/gdm.nix
          ];
        };
      };
    };
}
