{ pkgs, ... }:

{
  # **Full disclosure:** This part is fully LLM-generated. I have only verified that it works as explained.
  #
  # The onboard AMD 500-series/ASMedia ASM1042A xHCI controller (PCI 02:00.0, ACPI wake source "PTXH") aborts suspend
  # within milliseconds when it's a wakeup source, immediately bouncing the system back on and leaving the NVIDIA GPU in
  # a bad state (Xid 13), which crashes the compositor. Same failing xhci_hcd log line ("xHC error in resume, USBSTS 0x401,
  # Reinit") reported on this exact PCI address elsewhere: https://bbs.archlinux.org/viewtopic.php?id=300818. Disabling
  # a controller's ACPI wakeup to stop it from breaking suspend is a known workaround for xHCI controllers, e.g.:
  # https://gist.github.com/ioggstream/8f380d398aef989ac455b93b92d42048
  #
  # Trade-off: input devices on this controller (webcam, mic, wireless mouse/keyboard receiver, ...) can no longer wake
  # the machine from suspend. Use the power button to wake instead.
  systemd.services.disable-xhci-wakeup = {
    description = "Disable ACPI wakeup on the AM4 chipset xHCI controller (PTXH)";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.writeShellScript "disable-xhci-wakeup" ''
        echo disabled > /sys/bus/pci/devices/0000:02:00.0/power/wakeup
      ''}";
    };
  };
}
