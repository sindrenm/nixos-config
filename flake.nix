{
  description = "My NixOS Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    agenix.url = "github:ryantm/agenix";
    stylix.url = "github:danth/stylix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, home-manager, ... }@inputs:
    {
      nixosConfigurations = {
        sindrenm-home = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };

          modules = [
            home-manager.nixosModules.home-manager
            inputs.stylix.nixosModules.stylix

            # Hosts
            ./hosts/sindrenm-home/configuration.nix

            # Modules
            ./modules/common.nix
            ./modules/nvidia.nix

            # Users
            ./users/sindre.nix

            # Services
            ./modules/services/desktop-managers/gnome.nix
            ./modules/services/display-managers/gdm.nix

            # System Programs
            ./modules/programs/adb.nix

            # Themes
            ./modules/themes/current.nix
          ];
        };

        sindrenm-work = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };

          modules = [
            home-manager.nixosModules.home-manager
            inputs.stylix.nixosModules.stylix

            # Hosts
            ./hosts/sindrenm-work/configuration.nix

            # Modules
            ./modules/common.nix
            ./modules/nvidia.nix

            # Hardware
            ./modules/hardware/tuxedo.nix

            # Users
            ./users/sindre.nix

            # Services
            ./modules/services/desktop-managers/gnome.nix
            ./modules/services/display-managers/gdm.nix

            # System Programs
            ./modules/programs/adb.nix

            # Themes
            ./modules/themes/current.nix
          ];
        };
      };
    };
}
