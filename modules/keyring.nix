{ pkgs, ... }:

{
  services.gnome.gnome-keyring.enable = true;

  # GDM's actual authentication happens via the “gdm-password” PAM service
  # specifically, not just “gdm”, both are needed for the keyring
  # to auto-unlock using your login password under GDM.
  security.pam.services.gdm.enableGnomeKeyring = true;
  security.pam.services.gdm-password.enableGnomeKeyring = true;

  # GUI to inspect/manage stored secrets
  programs.seahorse.enable = true;

  environment.systemPackages = [
    pkgs.libsecret # provides `secret-tool`
  ];
}
