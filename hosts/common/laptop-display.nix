# Lid and external-display handling for the built-in laptop display, shared by the laptops. Ships the Lua module
# without loading it; each host's own display file calls `require("laptop-display").setup({ scale = … })`.
{
  home-manager.users.sindre.wayland.windowManager.hyprland.extraLuaFiles.laptop-display = {
    content = ./laptop-display.lua;
    autoLoad = false;
  };
}
