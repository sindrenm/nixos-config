# Remove once https://github.com/AprilNEA/OpenLogi/pull/2494 lands.

{ flake }:

final: prev:

let
  package = flake.packages.${final.stdenv.hostPlatform.system}.openlogi;
  hasFix = builtins.any (p: prev.lib.getName p == "zstd") (package.buildInputs or [ ]);
in
{
  openlogi =
    if hasFix then
      throw "overlays/openlogi.nix: the OpenLogi flake's package now includes zstd, remove this overlay"
    else
      package.overrideAttrs (old: {
        buildInputs = (old.buildInputs or [ ]) ++ [ final.zstd ];
      });
}
