{
  home-manager.users.sindre =
    { lib, osConfig, ... }:
    lib.mkIf osConfig.networking.networkmanager.enable {
      programs.nushell.extraConfig = lib.mkAfter (lib.fileContents ./wifi-scan.nu);
    };
}
