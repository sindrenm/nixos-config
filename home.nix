{ config, pkgs, ... }:

{
  home.username = "sindre";
  home.homeDirectory = "/home/sindre";

  # Let Home Manager manage itself.
  programs.home-manager.enable = true;

  # -----------------------------------------------------------------------
  # Dev tooling / VCS
  # -----------------------------------------------------------------------

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    neovim = {
      enable = true;
      defaultEditor = true;
      package = pkgs.neovim; # use nightly overlay
      sideloadInitLua = true; # manage my own Lua config
    };
  };

  home.packages = with pkgs; [
    # --- Browsers ---
    firefox

    # --- Version control / dev tooling ---
    difftastic
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
    ripgrep
    speedtest-cli
    starship
    tokei
    yazi
    zoxide

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

    # --- Desktop tweaks / diagnostics ---
    gnome-tweaks
    gpu-viewer
    mesa-demos

    # --- Password / secrets ---
    bitwarden-cli
    bitwarden-desktop

    # --- Android / mobile ---
    scrcpy
  ];

  home.stateVersion = "26.05"; # match system.stateVersion
}
