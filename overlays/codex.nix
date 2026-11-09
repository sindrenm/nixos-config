# Remove once https://github.com/NixOS/nixpkgs/issues/585124 is fixed.

final: prev:

let
  fixInputs = [
    final.aws-lc
    final.oniguruma
    final.sqlite
    final.zstd
  ];
  fixNames = map prev.lib.getName fixInputs;
  hasFix = builtins.any (p: builtins.elem (prev.lib.getName p) fixNames) (
    prev.codex.buildInputs or [ ]
  );
in
{
  codex =
    if hasFix then
      throw "overlays/codex.nix: nixpkgs' codex now includes some of ${toString fixNames} (NixOS/nixpkgs#585124), remove this overlay"
    else
      prev.codex.overrideAttrs (old: {
        buildInputs = (old.buildInputs or [ ]) ++ fixInputs;
      });
}
