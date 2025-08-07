{
  description = "My NixOS Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs =
    { nixpkgs, ... }@inputs:
    {
      nixosConfigurations = {
        home = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };

          modules = [
            ./hosts/home/configuration.nix
            ./modules/common.nix
            ./modules/nvidia.nix

            # Users
            ./users/sindre.nix

            # Services
            ./modules/services/desktop-managers/gnome.nix
            ./modules/services/display-managers/gdm.nix

            # Programs
            ./modules/programs/fish.nix
            ./modules/programs/git.nix
            ./modules/programs/neovim.nix
          ];
        };
      };
    };
}
