{
  description = "sindrenm-home-nixos system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, neovim-nightly-overlay, home-manager, ... }:
    let
      mkHost = hostname: nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/${hostname}/configuration.nix

          {
            nixpkgs.overlays = [ neovim-nightly-overlay.overlays.default ];
          }

          home-manager.nixosModules.home-manager

          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.sindre = import ./home.nix;
          }
        ];
      };
    in
    {
      nixosConfigurations.sindrenm-home-nixos = mkHost "sindrenm-home-nixos";
    };
}
