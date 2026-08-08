{ pkgs, ... }:

{
  home.packages = with pkgs; [
    carapace
  ];

  programs.starship = {
    enable = true;

    settings = {
      git_branch.disabled = true;
      git_commit.disabled = true;

      custom.jj = {
        command = "prompt";
        format = "$output";
        ignore_timeout = true;
        shell = [
          "starship-jj"
          "--ignore-working-copy"
          "starship"
        ];
        use_stdin = false;
        when = true;
      };
    };
  };
}
