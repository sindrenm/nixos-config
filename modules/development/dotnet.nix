{
  home-manager.users.sindre =
    { pkgs, ... }:
    let
      sdk = pkgs.dotnetCorePackages.sdk_10_0_4xx;

      # libsecret has to sit on dotnet's own library path in order for the credential provider to find it with
      # `dotnet <dll>`. Otherwise it'll default back to plain-text token storage for the Azure Artifacts feed.
      #
      # The wrapper has to replace `share/dotnet/dotnet` rather than `bin/dotnet`: tooling that discovers the SDK
      # through MSBuildLocator (roslyn-ls, among others) derives DOTNET_ROOT from `dirname (realpath (which dotnet))`,
      # so the binary that `bin/dotnet` resolves to must sit next to `sdk/` and `shared/`. A wrapper script directly
      # in `bin/` terminates the symlink chain there and leaves those tools with "No .NET SDKs were found".
      dotnet = pkgs.symlinkJoin {
        name = "dotnet-sdk-with-libsecret";
        paths = [ sdk ];
        nativeBuildInputs = [ pkgs.makeWrapper ];
        postBuild = ''
          # `share/dotnet` comes through as a symlink into the read-only SDK, so expand it into a real directory
          # before replacing the host binary inside it.
          rm $out/share/dotnet
          mkdir -p $out/share/dotnet
          ln -s ${sdk}/share/dotnet/* $out/share/dotnet/

          rm $out/bin/dotnet $out/share/dotnet/dotnet
          makeWrapper ${sdk}/share/dotnet/dotnet $out/share/dotnet/dotnet \
            --prefix LD_LIBRARY_PATH : ${pkgs.libsecret}/lib
          ln -s ../share/dotnet/dotnet $out/bin/dotnet
        '';
      };
    in
    {
      home.packages = with pkgs; [
        azure-artifacts-credprovider
        azure-cli
        dotnet
      ];

      sessionVariables = {
        DOTNET_ROOT = "${dotnet}/share/dotnet";
        DOTNET_CLI_TELEMETRY_OPTOUT = "1";

        # Lets `dotnet restore --interactive` authenticate against the private Azure Artifacts feed.
        NUGET_PLUGIN_PATHS = "${pkgs.azure-artifacts-credprovider}/lib/azure-artifacts-credprovider/CredentialProvider.Microsoft.dll";
      };
    };
}
