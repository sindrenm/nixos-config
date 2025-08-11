let
  # Expected to provide the following:
  # - emailAddress
  private = import ./git/git.private.nix;
in
{
  programs.git = {
    enable = true;

    userName = "Sindre Moen";
    userEmail = private.emailAddress;

    signing = {
      key = "/home/sindre/.ssh/id_ed25519.pub";
      format = "ssh";
      signByDefault = true;
    };

    difftastic = {
      enable = true;
    };

    ignores = [
      ".envrc"
    ];

    aliases = {
      bicep = "bisect";
      co = "checkout";
      cb = "checkout -b";
      ci = "commit -v";
      cp = "cherry-pick";
      st = "status";
      br = "branch -vv";
      df = "diff";
      lg = "log --graph --pretty=format:'%C(red)%h%Creset %C(green)%ad%Creset | %s%C(yellow)%d%Creset %C(bold blue)<%an>%Creset' --date=short";
      since = "!f() { git lg $1..HEAD; }; f";
      last = "!f() { git lg --max-count $1; }; f";
      pr = "pull --rebase --ff-only";
      dfc = "diff --cached";
      rob = "!f() { git fetch -p && for branch in `git branch -vv | grep ': gone]' | awk '{print $1}'`; do git branch -D $branch; done }; f";
      tags = "tag --list --sort=-creatordate";
    };

    extraConfig = {
      core = {
        pager = "less -RRSX";
        editor = "nvim";
      };

      init.defaultBranch = "main";

      push = {
        default = "simple";
        autoSetupRemote = true;
      };

      pull.rebase = false;

      clean.requireForce = false;

      merge.conflictstyle = "diff3";

      rebase.updateRefs = true;

      color = {
        ui = "auto";
        diff.whitespace = "red reverse";
      };

      github.user = "sindrenm";
    };
  };
}
