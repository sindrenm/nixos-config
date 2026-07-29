# Edit this configuration file to define what should be installed on your
# system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ ./hardware-configuration.nix ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # ---------------------------------------------------------------------
  # Bootloader
  # ---------------------------------------------------------------------

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 5;

  # ---------------------------------------------------------------------
  # NVIDIA GPU
  # ---------------------------------------------------------------------

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  # ---------------------------------------------------------------------
  # Networking
  # ---------------------------------------------------------------------

  networking.hostName = "sindrenm-home-nixos";
  networking.networkmanager.enable = true;

  # Locale / keyboard / time
  # ---------------------------------------------------------------------

  time.timeZone = "Europe/Oslo";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";
  services.xserver.xkb.layout = "us";

  # ---------------------------------------------------------------------
  # Swap
  # ---------------------------------------------------------------------

  zramSwap.enable = true;

  # ---------------------------------------------------------------------
  # Desktop: GNOME (full plumbing) + Hyprland (selectable at login)
  # ---------------------------------------------------------------------

  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  programs.hyprland.enable = true;

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-gtk
    pkgs.xdg-desktop-portal-hyprland
  ];

  # ---------------------------------------------------------------------
  # Services matching things that were separate packages/units on CachyOS
  # ---------------------------------------------------------------------

  hardware.bluetooth.enable = true;
  services.power-profiles-daemon.enable = true;
  security.rtkit.enable = true;
  services.upower.enable = true;
  boot.plymouth.enable = true;

  # ---------------------------------------------------------------------
  # Users
  # ---------------------------------------------------------------------

  users.users.sindre = {
    isNormalUser = true;
    description = "sindre";
    extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" ];
    shell = pkgs.nushell;
  };

  environment.shells = [ pkgs.nushell ];

  # ---------------------------------------------------------------------
  # Programs
  # ---------------------------------------------------------------------

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    package = pkgs.neovim; # use nightly overlay
  };

  programs.nh = {
    enable = true;
    flake = "/home/sindre/nixos-config";

    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
  };

  # ---------------------------------------------------------------------
  # Packages
  # ---------------------------------------------------------------------
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # --- Browsers ---
    firefox

    # --- Version control / dev tooling ---
    difftastic
    direnv
    git
    jujutsu
    stow

    # --- Editors / IDE mgmt ---
    jetbrains-toolbox
    kotlin-language-server

    # --- Shell / terminal / CLI tools ---
    atuin
    bat
    carapace
    eza
    fd
    kitty
    nushell
    ripgrep
    starship
    tokei
    yazi
    zoxide

    # --- Fonts ---
    cantarell-fonts
    jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji

    # --- Hyprland ecosystem ---
    hypridle
    hyprlock
    hyprpaper
    hyprpicker
    hyprshot
    wl-clipboard
    wlogout

    # --- Media / creative ---
    deluge
    discord
    gimp
    obs-studio
    signal-desktop
    slack
    stremio-linux-shell
    vlc
    zathura
    zathuraPkgs.zathura_pdf_mupdf

    # --- System / hardware utilities ---
    efibootmgr
    gpu-viewer
    hwinfo
    mesa-demos
    rsync
    unzip
    wget

    # --- Networking / security ---
    gnome-tweaks
    inetutils
    openssh
    speedtest-cli

    # --- Password / secrets ---
    bitwarden-cli
    bitwarden-desktop

    # --- Android / mobile ---
    scrcpy
  ];

  system.stateVersion = "26.05";
}
