{ lib, ... }:

{
  hardware.printers.ensurePrinters = [
    {
      name = "office-kitchen";
      description = "Kitchen";
      location = "Next to the kitchen";
      deviceUri = "ipp://10.51.242.87/ipp/print";
      model = "everywhere";
      ppdOptions.PageSize = "A4";
    }
    {
      name = "office-reception";
      description = "Reception";
      location = "Behind the reception";
      deviceUri = "ipp://10.51.242.15/ipp/print";
      model = "everywhere";
      ppdOptions.PageSize = "A4";
    }
  ];

  hardware.printers.ensureDefaultPrinter = "office-kitchen";

  # `hardware.printers` provisions the queues from cups' own `postStart`, and `everywhere`
  # queries each printer directly, so the script can only succeed while we're on the office
  # network. Without this it aborts on the first printer that doesn't answer — which both
  # skips every printer after it and fails `cups.service`, putting cupsd in a restart loop
  # that makes the queues flicker in and out of the print dialog.
  systemd.services.cups.postStart = lib.mkBefore "set +e";
}
