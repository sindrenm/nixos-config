{
  home-manager.users.sindre =
    { config, lib, ... }:
    {
      options.sessionVariables = lib.mkOption {
        type = lib.types.attrsOf lib.types.str;
        default = { };
        description = "Environment variables to export from every session entry point: the login shell.";
      };

      config = {
        home.sessionVariables = config.sessionVariables;
        systemd.user.sessionVariables = config.sessionVariables;
      };
    };
}
