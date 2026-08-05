# Relax hyprland glaze dependency. At the time of this writing, it is too
# strict and fails to build with glaze >= 8.0.0.
#
# TODO: Drop once https://github.com/NixOS/nixpkgs/pull/549253 lands on
# nixos-unstable.
final: prev: {
  hyprland = prev.hyprland.overrideAttrs (oldAttrs: {
    postPatch = ''
      substituteInPlace CMakeLists.txt --replace-fail "glaze 7...<8" "glaze"
    '' + (oldAttrs.postPatch or "");
  });
}
