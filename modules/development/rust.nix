{
  home-manager.users.sindre = { pkgs, ... }: {
    home.packages = with pkgs; [
      cargo
      cargo-edit
      cargo-expand
      cargo-nextest
      cargo-watch
      clippy
      rustc
      rustfmt
    ];
  };
}
