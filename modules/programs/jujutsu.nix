let
  # Expected to provide the following:
  # - emailAddress
  # - signingKeyPath
  private = import ./jujutsu/jujutsu.private.nix;
in
{
  config.programs.jujutsu = {
    enable = true;

    settings = {
      user = {
        email = private.emailAddress;
        name = "Sindre Moen";
      };

      ui = {
        default-command = "log";
        diff-formatter = [
          "difft"
          "--color=always"
          "$left"
          "$right"
        ];
        pager = ":builtin";
      };

      signing = {
        backend = "ssh";
        behavior = "own";
        key = private.signingKeyPath;
      };
    };
  };
}
