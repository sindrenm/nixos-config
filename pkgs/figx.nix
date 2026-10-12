{
  lib,
  rustPlatform,
  src,
}:

# My own fork with Linux keyring support until https://github.com/tonykolomeytsev/figx/pull/20 lands.
let
  cargoVersion = (lib.importTOML "${src}/Cargo.toml").workspace.package.version;
  date = builtins.substring 0 8 src.lastModifiedDate;
in
rustPlatform.buildRustPackage {
  pname = "figx";
  version = "${cargoVersion}-unstable-${builtins.substring 0 4 date}-${builtins.substring 4 2 date}-${builtins.substring 6 2 date}";

  inherit src;

  # Bump after `nix flake update figx-src` if the fork's Cargo.lock changed.
  cargoHash = "sha256-Hn0PGutTxP5qHYg9SdQhkwHV2GJTDsfzTuHCLt4jLjY=";

  cargoBuildFlags = [ "--package" "figx" ];
  doCheck = false;

  meta = {
    description = "Pragmatic CLI tool for importing design assets from Figma into your codebase";
    homepage = "https://github.com/sindrenm/figx";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.linux;
    mainProgram = "figx";
  };
}
