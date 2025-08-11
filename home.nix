{ config, inputs, ... }:

{
  home.stateVersion = "25.05"; # keep same as system version

  imports = [
    inputs.agenix.homeManagerModules.default

    ./modules/dconf.nix
    ./modules/fontconfig.nix
    ./modules/programs/bat.nix
    ./modules/programs/btop.nix
    ./modules/programs/direnv.nix
    ./modules/programs/eza.nix
    ./modules/programs/fd.nix
    ./modules/programs/fish.nix
    ./modules/programs/fzf.nix
    ./modules/programs/gh.nix
    ./modules/programs/git.nix
    ./modules/programs/jujutsu.nix
    ./modules/programs/neovim.nix
    ./modules/programs/ripgrep.nix
    ./modules/programs/starship.nix
    ./modules/programs/wezterm.nix
    ./modules/programs/zoxide.nix
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
