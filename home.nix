{ ... }:

{
  home.stateVersion = "25.05"; # keep same as system version

  imports = [
    ./modules/programs/direnv.nix
    ./modules/programs/fish.nix
    ./modules/programs/fzf.nix
    ./modules/programs/git.nix
    ./modules/programs/starship.nix
    ./modules/programs/wezterm.nix
    ./modules/programs/zoxide.nix
  ];
}
