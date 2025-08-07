{ pkgs, ... }:
{
  config = {
    programs.fish.enable = true;

    users.users.sindre = {
      description = "Sindre";
      isNormalUser = true;
      shell = pkgs.fish;

      extraGroups = [
        "adbusers"
        "kvm"
        "networkmanager"
        "wheel"
      ];

      packages = with pkgs; [
        androidStudioPackages.canary
        azure-cli
        bitwarden-desktop
        chezmoi
        jetbrains.idea-ultimate
        jetbrains.rider
        stremio
      ];
    };

    home-manager.users.sindre = {
      imports = [ ../home.nix ];
    };
  };
}
