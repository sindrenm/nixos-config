{
  # Fn-keys, keyboard backlight control and battery charge limiting on TUXEDO hardware.
  #
  # `hardware.tuxedo-rs` is deliberately left off as its performance profiles overlap
  # with power-profiles-daemon from ../../modules/power.nix.
  hardware.tuxedo-drivers = {
    enable = true;

    # Cap charging at 90% to slow battery wear. The OS still reports 100% when the cap is reached.
    settings.charging-profile = "balanced";
  };

  # Intel-specific thermal management. The 14900HX throttles badly without it under sustained load.
  services.thermald.enable = true;

  services.logind.settings.Login = {
    HandleLidSwitch = "suspend";
    HandleLidSwitchExternalPower = "lock";
    HandleLidSwitchDocked = "ignore";
  };

  # The laptop's profile button above the keyboard emits Super+Alt+F6. Hook it up.
  home-manager.users.sindre.wayland.windowManager.mango.settings.bindl = [
    "SUPER+ALT,F6,spawn,noctalia msg power-cycle"
  ];
}
