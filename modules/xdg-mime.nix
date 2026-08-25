{
  home-manager.users.sindre = {
    xdg.mimeApps = {
      enable = true;

      defaultApplications = {
        "application/x-extension-htm" = "zen.desktop";
        "application/x-extension-html" = "zen.desktop";
        "application/x-extension-shtml" = "zen.desktop";
        "application/x-extension-xht" = "zen.desktop";
        "application/x-extension-xhtml" = "zen.desktop";
        "application/xhtml+xml" = "zen.desktop";
        "text/html" = "zen.desktop";
        "text/plain" = "v.desktop";
        "x-scheme-handler/bitwarden" = "bitwarden.desktop";
        "x-scheme-handler/chrome" = "zen.desktop";
        "x-scheme-handler/claude" = "com.anthropic.Claude.desktop";
        "x-scheme-handler/claude-cli" = "claude-code-url-handler.desktop";
        "x-scheme-handler/http" = "zen.desktop";
        "x-scheme-handler/https" = "zen.desktop";
        "x-scheme-handler/jetbrains" = "jetbrainsd.desktop";
        "x-scheme-handler/slack" = "slack.desktop";
      };
    };
  };
}
