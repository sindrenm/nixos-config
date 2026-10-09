{
  home-manager.users.sindre = {
    xdg.mimeApps = {
      enable = true;

      defaultApplications = {
        "application/x-extension-htm" = "firefox.desktop";
        "application/x-extension-html" = "firefox.desktop";
        "application/x-extension-shtml" = "firefox.desktop";
        "application/x-extension-xht" = "firefox.desktop";
        "application/x-extension-xhtml" = "firefox.desktop";
        "application/xhtml+xml" = "firefox.desktop";
        "text/html" = "firefox.desktop";
        "text/plain" = "v.desktop";
        "x-scheme-handler/bitwarden" = "bitwarden.desktop";
        "x-scheme-handler/chrome" = "firefox.desktop";
        "x-scheme-handler/claude" = "com.anthropic.Claude.desktop";
        "x-scheme-handler/claude-cli" = "claude-code-url-handler.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "x-scheme-handler/jetbrains" = "jetbrainsd.desktop";
        "x-scheme-handler/slack" = "slack.desktop";
      };
    };
  };
}
