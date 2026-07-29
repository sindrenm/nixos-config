{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    efibootmgr
    hwinfo
    inetutils
    openssh
    rsync
    speedtest-cli
    unzip
    wget
  ];
}
