{ ... }:

{
  programs.nh = {
    enable = true;
    flake = "/home/sindre/nixos-config";

    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
  };

  programs.nix-ld.enable = true;
}
