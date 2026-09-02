{
  home-manager.users.sindre =
    { pkgs, ... }:
    let
      # libsecret has to sit on dotnet's own library path in order for the credential provider to find it with
      # `dotnet <dll>`. Otherwise it'll default back to plain-text token storage for the Azure Artifacts feed.
      dotnet = pkgs.symlinkJoin {
        name = "dotnet-sdk-with-libsecret";
        paths = [ pkgs.dotnetCorePackages.sdk_10_0_3xx ];
        nativeBuildInputs = [ pkgs.makeWrapper ];
        postBuild = ''
          wrapProgram $out/bin/dotnet --prefix LD_LIBRARY_PATH : ${pkgs.libsecret}/lib
        '';
      };

      dotnetEnvVariables = {
        DOTNET_ROOT = "${dotnet}/share/dotnet";
        DOTNET_CLI_TELEMETRY_OPTOUT = "1";

        # Lets `dotnet restore --interactive` authenticate against the private Azure Artifacts feed.
        NUGET_PLUGIN_PATHS = "${pkgs.azure-artifacts-credprovider}/lib/azure-artifacts-credprovider/CredentialProvider.Microsoft.dll";
      };
    in
    {
      home.packages = with pkgs; [
        azure-artifacts-credprovider
        azure-cli
        dotnet
      ];

      home.sessionVariables = dotnetEnvVariables;
      programs.nushell.environmentVariables = dotnetEnvVariables;
      systemd.user.sessionVariables = dotnetEnvVariables;
    };
}
