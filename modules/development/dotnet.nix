{
  home-manager.users.sindre =
    { pkgs, ... }:
    let
      dotnet = pkgs.dotnetCorePackages.sdk_10_0_4xx;

      # The credential provider P/Invokes libsecret to keep the Azure Artifacts token in the keyring, and NuGet
      # launches plugins as `dotnet <dll>` — so the LD_LIBRARY_PATH baked into its own `bin/` wrapper never applies.
      # .NET probes the application directory for native libraries (that's how the bundled libmsalruntime.so is
      # found), so dropping libsecret in next to the dll is enough. Without it the provider silently falls back to
      # plain-text token storage.
      credentialProvider = pkgs.azure-artifacts-credprovider.overrideAttrs (prev: {
        postInstall = (prev.postInstall or "") + ''
          ln -s ${pkgs.libsecret}/lib/libsecret-1.so.0 $out/lib/azure-artifacts-credprovider/
        '';
      });
    in
    {
      home.packages = [
        credentialProvider
        dotnet
        pkgs.azure-cli
      ];

      sessionVariables = {
        DOTNET_ROOT = "${dotnet}/share/dotnet";
        DOTNET_CLI_TELEMETRY_OPTOUT = "1";

        # Lets `dotnet restore --interactive` authenticate against the private Azure Artifacts feed.
        NUGET_PLUGIN_PATHS = "${credentialProvider}/lib/azure-artifacts-credprovider/CredentialProvider.Microsoft.dll";
      };
    };
}
