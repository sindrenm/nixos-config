{
  home-manager.users.sindre = { pkgs, ... }: {
    home.packages = with pkgs; [
      android-cli
      android-tools
      androidStudioPackages.canary
      androidStudioPackages.stable
    ];
  };
}
