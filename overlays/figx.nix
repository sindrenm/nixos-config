{ src }:

final: prev:

{
  figx = final.callPackage ../pkgs/figx.nix { inherit src; };
}
