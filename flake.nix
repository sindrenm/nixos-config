{
  description = "sindrenm NixOS system flake";

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

    openlogi = {
      url = "github:AprilNEA/OpenLogi";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
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
      nixpkgs,
      noctalia,
      openlogi,
      zen-browser,
      ...
    }:
    let
      mkHost =
        hostname:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";

          specialArgs = { inherit hostname; };

          modules = [
            ./hosts/${hostname}/configuration.nix

            {
              nixpkgs.overlays = [
                claude-desktop.overlays.default
                neovim-nightly-overlay.overlays.default

                (import ./overlays/android-studio-canary.nix)
                (import ./overlays/figx.nix)
                (import ./overlays/kotlin-lsp.nix)
              ];
            }

            mangowm.nixosModules.mango

            home-manager.nixosModules.home-manager

            openlogi.nixosModules.default

            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit catppuccin catppuccin-palette;
                inherit mangowm;
                inherit nixCats;
                inherit noctalia;
                inherit zen-browser;
              };
            }
          ];
        };
    in
    {
      nixosConfigurations = {
        sindrenm-home-nixos = mkHost "sindrenm-home-nixos";
        sindrenm-work-nixos = mkHost "sindrenm-work-nixos";
      };
    };
}
