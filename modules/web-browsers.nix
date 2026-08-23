{
  home-manager.users.sindre =
    {
      pkgs,
      zen-browser,
      ...
    }:
    {
      home.packages = with pkgs; [
        firefox
        zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];
    };
}
