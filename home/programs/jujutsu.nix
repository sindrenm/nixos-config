{
  programs.jujutsu = {
    enable = true;

    settings = {
      user = {
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
        key = "/home/sindre/.ssh/id_ed25519.pub";
      };
    };
  };
}
