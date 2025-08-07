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

    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [
      bat
      btop
      difftastic
      direnv
      discord
      eza
      fd
      firefox
      fish
      fzf
      gh
      git
      gnome-tweaks
      google-chrome
      jujutsu
      kotlin
      lshw
      lua-language-server
      nerd-fonts.jetbrains-mono
      nil # nix language server
      nix-direnv
      nix-tree
      nodenv
      pyenv
      rbenv
      rust-analyzer
      rustup
      slack
      taplo
      typst
      vlc
      vscode-langservers-extracted
      wezterm
      wget
      wl-clipboard
      yaml-language-server
      zoxide
      zulu
    ];
  };
}
