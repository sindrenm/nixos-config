{ pkgs, ... }:

{
  config = {
    nix.settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      auto-optimise-store = true;
    };

    nix.gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 14d";
    };

    networking.networkmanager.enable = true;

    time.timeZone = "Europe/Oslo";
    i18n.defaultLocale = "en_US.UTF-8";

    # Enable sound with Pipewire.
    security.rtkit.enable = true;
    services.pulseaudio.enable = false;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    nixpkgs.config = {
      allowUnfree = true;
      android_sdk.accept_license = true;
    };

    environment.systemPackages = with pkgs; [
      discord
      firefox
      gnome-tweaks
      google-chrome
      kotlin
      lshw
      lua-language-server
      nerd-fonts.jetbrains-mono
      nil # nix language server
      nix-tree
      rust-analyzer
      slack
      taplo
      typst
      vlc
      vscode-langservers-extracted
      wget
      wl-clipboard
      yaml-language-server
      zulu
    ];
  };
}
