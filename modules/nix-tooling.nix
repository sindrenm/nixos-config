{ pkgs, ... }:

{
  programs.nh = {
    enable = true;
    flake = "/home/sindre/nixos-config";

    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
  };

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      alsa-lib
      cups
      dbus
      fontconfig
      freetype
      glib
      gtk3
      libGL
      libsecret
      libx11
      libxcomposite
      libxcursor
      libxext
      libxi
      libxinerama
      libxkbcommon
      libxrandr
      libxrender
      libxtst
      vulkan-loader
      wayland
      zlib
    ];
  };
}
