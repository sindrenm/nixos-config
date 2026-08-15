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

    mangowm = {
      url = "github:mangowm/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixCats.url = "github:BirdeeHub/nixCats-nvim";

    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      catppuccin,
      catppuccin-palette,
      claude-desktop,
      home-manager,
      mangowm,
      neovim-nightly-overlay,
      nixCats,
      noctalia,
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

                (import ./overlays/figx.nix)
                (import ./overlays/kotlin-lsp.nix)
              ];
            }

            mangowm.nixosModules.mango

            home-manager.nixosModules.home-manager

            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit catppuccin catppuccin-palette;
                inherit mangowm;
                inherit nixCats;
                inherit noctalia;
              };
            }
          ];
        };
    in
    {
      nixosConfigurations.sindrenm-home-nixos = mkHost "sindrenm-home-nixos";
    };
}
