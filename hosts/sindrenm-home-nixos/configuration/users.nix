{ pkgs, ... }:

{
  users.users.sindre = {
    isNormalUser = true;
    description = "sindre";
    extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" ];
    shell = pkgs.nushell;
  };

  environment.shells = [ pkgs.nushell ];
}
