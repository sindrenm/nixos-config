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

                # hyprexpo isn't in nixpkgs. Built directly against this
                # generation's own hyprland package for a guaranteed ABI
                # match, rather than via the plugin's own flake.nix, which
                # pins an unrelated (and older) Hyprland version.
                (final: prev: {
                  hyprexpo = prev.hyprlandPlugins.mkHyprlandPlugin {
                    pluginName = "hyprexpo";
                    # Pinned to the exact Hyprland version tag: plugin ABI is
                    # version-sensitive, and this fork tags per Hyprland release.
                    version = "0.56.1+3";
                    src = prev.fetchFromGitHub {
                      owner = "sandwichfarm";
                      repo = "hyprexpo";
                      rev = "40352e2663deded7c6536b2fda1ed18a97234a80";
                      hash = "sha256-lI52XGlHMAXhn8ztpRkzefFy5ZnTIsQgAlTEVYTXseA=";
                    };
                    inherit (prev.hyprland) nativeBuildInputs;
                    meta = with prev.lib; {
                      homepage = "https://github.com/sandwichfarm/hyprexpo";
                      description = "An enhanced Hyprland workspaces overview plugin";
                      license = licenses.bsd3;
                      platforms = platforms.linux;
                    };
                  };
                })
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
