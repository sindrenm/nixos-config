let
  # See git.private.tmpl.nix
  private = import ./git.private.nix;
in
{
  programs.git = {
    enable = true;

    config = {
      core = {
        pager = "less -RRSX";
        editor = "nvim";
      };

      user = {
        name = "Sindre Moen";
        email = private.emailAddress;
        signingKey = private.signingKeyPath;
      };

      diff.external = "difft";

      commit.gpgsign = true;

      tag.gpgsign = true;

      gpg.format = "ssh";

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

      alias = {
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
    };
  };
}
