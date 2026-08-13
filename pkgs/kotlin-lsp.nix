{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
  makeWrapper,
  alsa-lib,
  freetype,
  libxkbcommon,
  libxrender,
  libxtst,
  wayland,
  zlib,
}:

stdenv.mkDerivation rec {
  pname = "kotlin-lsp";
  version = "262.9593.0";

  # Not in nixpkgs yet: https://discourse.nixos.org/t/package-request-kotlin-lsp/74476
  # Official standalone releases: https://github.com/Kotlin/kotlin-lsp/releases
  src = fetchurl {
    url = "https://download-cdn.jetbrains.com/language-server/kotlin-server/${version}/kotlin-server-${version}.tar.gz";
    hash = "sha256-LZnY4Zj75KqPRIHjd5lyTOlIA7TqEqYLQWBA4/zXzF4=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
    makeWrapper
  ];

  # Bundles its own JetBrains Runtime (jbr/), so only the libraries that
  # runtime and the IntelliJ-platform native bits (pty4j, font rendering)
  # need at runtime have to be provided.
  buildInputs = [
    stdenv.cc.cc.lib
    alsa-lib
    freetype
    libxkbcommon
    libxrender
    libxtst
    wayland
    zlib
  ];

  # kotlin-lsp.sh is a deprecated shim that just execs bin/intellij-server,
  # which is what nvim-lspconfig's kotlin_lsp config invokes by default.
  installPhase = ''
    runHook preInstall

    mkdir -p $out/libexec
    cp -r . $out/libexec
    chmod -R u+w $out/libexec
    chmod +x $out/libexec/bin/intellij-server $out/libexec/jbr/bin/java

    mkdir -p $out/bin
    makeWrapper $out/libexec/bin/intellij-server $out/bin/intellij-server

    runHook postInstall
  '';

  meta = {
    description = "Kotlin Language Server by JetBrains";
    homepage = "https://github.com/Kotlin/kotlin-lsp";
    license = lib.licenses.asl20;
    platforms = [ "x86_64-linux" ];
    mainProgram = "intellij-server";
  };
}
