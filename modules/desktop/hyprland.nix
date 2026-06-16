# System-Ebene: Hyprland (Wayland-Compositor) aktivieren.
# Fenster-/Keybind-Konfiguration liegt in home/desktop/hyprland.nix.
{ ... }:

{
  programs.hyprland.enable = true;
}
