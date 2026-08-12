{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
}:

stdenv.mkDerivation rec {
  pname = "figx";
  version = "0.8.9";

  src = fetchurl {
    url = "https://github.com/tonykolomeytsev/figx/releases/download/v${version}/figx-linux-gnu-x86_64.tar.gz";
    hash = "sha256-xeo1FAL48HDSgbwXs+P2Be0NUMbQog5fApymBNgb4Wo=";
  };

  nativeBuildInputs = [ autoPatchelfHook ];
  buildInputs = [ stdenv.cc.cc.lib ];

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall
    install -Dm755 figx $out/bin/figx
    runHook postInstall
  '';

  meta = {
    description = "Pragmatic CLI tool for importing design assets from Figma into your codebase";
    homepage = "https://github.com/tonykolomeytsev/figx";
    license = lib.licenses.gpl3Only;
    platforms = [ "x86_64-linux" ];
    mainProgram = "figx";
  };
}
