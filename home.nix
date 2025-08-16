{ config, inputs, ... }:

{
  home.stateVersion = "25.05"; # keep same as system version

  imports = [
    inputs.agenix.homeManagerModules.default

    ./home/programs/atuin.nix
    ./home/programs/bat.nix
    ./home/programs/btop.nix
    ./home/programs/carapace.nix
    ./home/programs/direnv.nix
    ./home/programs/eza.nix
    ./home/programs/fd.nix
    ./home/programs/fish.nix
    ./home/programs/fuzzel.nix
    ./home/programs/fzf.nix
    ./home/programs/gh.nix
    ./home/programs/ghostty.nix
    ./home/programs/git.nix
    ./home/programs/jujutsu.nix
    ./home/programs/mpv.nix
    ./home/programs/neovim.nix
    ./home/programs/niri.nix
    ./home/programs/nushell.nix
    ./home/programs/qutebrowser.nix
    ./home/programs/ripgrep.nix
    ./home/programs/starship.nix
    ./home/programs/swaylock.nix
    ./home/programs/tmux.nix
    ./home/programs/waybar.nix
    ./home/programs/wezterm.nix
    ./home/programs/wlogout.nix
    ./home/programs/zoxide.nix
    ./home/services/mako.nix
    ./home/stylix.nix
  ];

  age.secrets = {
    git = {
      file = ./secrets/git.toml;
      path = "${config.xdg.configHome}/git/secret.toml";
    };

    jujutsu = {
      file = ./secrets/jujutsu.toml;
      path = "${config.xdg.configHome}/jj/conf.d/secret.toml";
    };
  };
}
