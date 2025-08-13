{
  programs.gh = {
    enable = true;

    hosts = {
      "github.com" = {
        git_protocol = "ssh";
        user = "sindrenm";
      };
    };

    settings = {
      git_protocol = "ssh";
    };
  };
}
