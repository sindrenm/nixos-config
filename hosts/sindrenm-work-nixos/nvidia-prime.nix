# Hybrid graphics. The Intel Raptor Lake UHD iGPU (PCI 00:02.0) drives the built-in panel; the RTX 4070 Max-Q
# (PCI 01:00.0) stays powered down until something is launched through `nvidia-offload`. Settings shared with the
# desktop's discrete-only setup live in ../common/nvidia-gpu.nix.
{ pkgs, ... }:

{
  # Bind the iGPU in the initrd so i915 always claims it. Both i915 and xe match its PCI ID, and if udev happens to load
  # xe first, xe refuses the device, i915 never loads, and only simpledrm is left on the boot VGA device. wlroots-based
  # compositors (mango) then pick that as the primary GPU, find only software rendering, and exit immediately.
  boot.initrd.kernelModules = [ "i915" ];

  # VA-API driver (iHD) for hardware video decoding/encoding on the iGPU, so video plays without waking the dGPU.
  hardware.graphics.extraPackages = [ pkgs.intel-media-driver ];

  hardware.nvidia = {
    # Lets the driver cut power to the dGPU entirely while it is idle. Requires PRIME offload, and is only supported on
    # Turing and newer — the 4070 is Ada, so this is fine.
    powerManagement.finegrained = true;

    prime = {
      offload = {
        enable = true;
        # Provides the `nvidia-offload` wrapper: `nvidia-offload blender`, etc.
        enableOffloadCmd = true;
      };

      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };
}
