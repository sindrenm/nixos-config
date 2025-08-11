let
  sindrenm-komplett = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGrHsUkM9u2jAmx6fqGQplrs+ida33uD/ZXYBuyQJas0";
  sindrenm-tuxedo = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJP5p8Ek/TUMSVRAERo9JRXee05nYLBz25rxS1RhWKAJ";

  sindre = [ sindrenm-komplett sindrenm-tuxedo ];
in
{
  "git.toml".publicKeys = sindre;
  "jujutsu.toml".publicKeys = sindre;
}
