{
  description = "My NixOS Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, home-manager, ... }@inputs:
    {
      nixosConfigurations = {
        home = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };

          modules = [
            home-manager.nixosModules.home-manager

            # Hosts
            ./hosts/home/configuration.nix

            # Modules
            ./modules/common.nix
            ./modules/nvidia.nix

            # Users
            ./users/sindre.nix

            # Services
            ./modules/services/desktop-managers/gnome.nix
            ./modules/services/display-managers/gdm.nix

            # Programs
            ./modules/programs/adb.nix
            ./modules/programs/fish.nix
            ./modules/programs/git.nix
            ./modules/programs/neovim.nix
          ];
        };
      };
    };
}
