# NVIDIA driver settings shared by the hosts with an NVIDIA GPU. Not part of ../../modules, which every host imports
# wholesale, so hosts without one (the Framework) don't get the driver. Import it explicitly from the host instead.
{ config, ... }:

{
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    powerManagement.enable = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];
}
