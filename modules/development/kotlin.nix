{
  home-manager.users.sindre = { pkgs, lib, ... }: {
    home.packages = with pkgs; [
      kotlin-cli
    ];

    # JetBrains' Kotlin CLI toolchain downloads its own JRE outside of Nix,
    # so it isn't patched with the usual NixOS rpaths.
    sessionVariables.LD_LIBRARY_PATH = lib.makeLibraryPath [
      pkgs.libglvnd
      pkgs.libx11
      pkgs.fontconfig.lib
      pkgs.stdenv.cc.cc.lib
    ] + ":/run/opengl-driver/lib";
  };
}
