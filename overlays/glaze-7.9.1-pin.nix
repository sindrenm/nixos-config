# Pins the glaze package to version 7.9.1 due to an unresolved breaking change
# in version 8.0.0. See https://github.com/NixOS/nixpkgs/issues/549201.

final: prev: {
  glaze = prev.glaze.overrideAttrs (oldAttrs: {
    version = "7.9.1";
    src = prev.fetchFromGitHub {
      owner = "stephenberry";
      repo = "glaze";
      tag = "v7.9.1";
      hash = "sha256-NRRq5MGF2f5PW0teYnq58ELzson+U6KHVPaY6r30KLA=";
    };
  });
}
