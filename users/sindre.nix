{ pkgs, ... }:
{
  config = {
    users.users.sindre = {
      description = "Sindre";
      isNormalUser = true;

      extraGroups = [
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
        starship
        stremio
      ];
    };
  };
}
