{
  home-manager.users.sindre =
    { config, lib, ... }:
    {
      options.sessionVariables = lib.mkOption {
        type = lib.types.attrsOf lib.types.str;
        default = { };
        description = "Environment variables to export from every session entry point: the login shell, \
          interactive nushell, and the systemd user manager.";
      };

      config = {
        home.sessionVariables = config.sessionVariables;
        programs.nushell.environmentVariables = config.sessionVariables;
        systemd.user.sessionVariables = config.sessionVariables;
      };
    };
}
