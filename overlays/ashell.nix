# Remove once https://github.com/NixOS/nixpkgs/pull/585301 lands.

final: prev:

let
  hasAwsLc = builtins.any (p: prev.lib.getName p == "aws-lc") (prev.ashell.buildInputs or [ ]);
in
{
  ashell =
    if hasAwsLc then
      throw "overlays/ashell.nix: nixpkgs' ashell now includes aws-lc (NixOS/nixpkgs#585301), remove this overlay"
    else
      prev.ashell.overrideAttrs (old: {
        buildInputs = (old.buildInputs or [ ]) ++ [ final.aws-lc ];
      });
}
