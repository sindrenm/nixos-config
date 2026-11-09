{ pkgs, ... }:
{
  # Grants non-root udev access to Keychron keyboards (e.g. K2 HE), needed for the
  # web-based Keychron Launcher / VIA configurator to talk to the device over WebHID.
  services.udev.packages = [
    pkgs.keychron-udev-rules
  ];

  # Covers the keyboard's bootloader-mode USB ID (a different VID/PID than runtime),
  # needed for the browser to flash new firmware onto the keyboard over WebUSB.
  hardware.keyboard.qmk.enable = true;

  # nixpkgs ships its own `programs.openlogi` module, which clashes with the one
  # from the official OpenLogi flake. Prefer the official flake.
  disabledModules = [ "programs/openlogi.nix" ];

  programs.openlogi = {
    enable = true;
    launchAtLogin = true;
  };
}
