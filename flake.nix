{
  description = "sindrenm-home-nixos system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin-palette = {
      url = "github:catppuccin/palette";
      flake = false;
    };

    claude-desktop = {
      url = "github:aaddrick/claude-desktop-debian";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixCats.url = "github:BirdeeHub/nixCats-nvim";
  };

  outputs =
    {
      self,
      catppuccin,
      catppuccin-palette,
      claude-desktop,
      home-manager,
      neovim-nightly-overlay,
      nixCats,
      nixpkgs,
      ...
    }:
    let
      mkHost =
        hostname:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/${hostname}/configuration.nix

            {
              nixpkgs.overlays = [
                claude-desktop.overlays.default
                neovim-nightly-overlay.overlays.default

                (import ./overlays/hyprland-glaze-patch.nix)
              ];
            }

            home-manager.nixosModules.home-manager

            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit catppuccin catppuccin-palette nixCats;
              };
              home-manager.users.sindre = import ./home.nix;
            }
          ];
        };
    in
    {
      nixosConfigurations.sindrenm-home-nixos = mkHost "sindrenm-home-nixos";
    };
}
