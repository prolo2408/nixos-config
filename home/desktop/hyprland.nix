{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    # Optional: xdg-desktop-portal setup
    xwayland.enable = true;

    # Declarative Hyprland settings
    settings = {
      "$mod" = "SUPER";

      # Basic monitor configuration
      monitor = ",preferred,auto,1";

      # Auto-start essential services
      exec-once = [
        "waybar"
        "hyprpaper"
      ];

      # Keybindings
      bind = [
        "$mod, T, exec, kitty"
        "$mod, Q, killactive,"
        "$mod, M, exit,"
        "$mod, D, exec, wofi --show drun"
        
        # Move focus with mod + arrow keys
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
      ];
    };
  };
}
