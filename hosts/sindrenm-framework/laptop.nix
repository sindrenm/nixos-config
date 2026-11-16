{ pkgs, ... }:

{
  # Intel-specific thermal management for the Core Ultra CPU.
  services.thermald.enable = true;

  # Core Ultra NPU (Intel AI Boost).
  hardware.cpu.intel.npu.enable = true;

  # VA-API driver (iHD) for hardware video decoding/encoding on the Intel Arc iGPU, e.g. in browsers and mpv.
  hardware.graphics.extraPackages = [ pkgs.intel-media-driver ];

  services.logind.settings.Login = {
    HandleLidSwitch = "suspend";
    HandleLidSwitchExternalPower = "lock";
    HandleLidSwitchDocked = "ignore";
  };
}
