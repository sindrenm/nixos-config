{ pkgs, inputs, ... }:
{
  programs.fish.enable = true;

  users.users.sindre = {
    description = "Sindre";
    isNormalUser = true;
    shell = pkgs.nushell;

    extraGroups = [
      "adbusers"
      "kvm"
      "networkmanager"
      "wheel"
    ];

    packages = with pkgs; [
      androidStudioPackages.canary
      azure-cli
      bitwarden-cli
      bitwarden-desktop
      chezmoi
      jetbrains.idea-ultimate
      jetbrains.rider
      kdePackages.breeze
      nixfmt
      statix
      stremio
    ];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };

    users.sindre = {
      imports = [ ../home.nix ];
    };
  };
}
