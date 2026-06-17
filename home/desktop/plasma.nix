{ pkgs, ... }: {
  programs.plasma = {
    enable = true;
    overrideConfig = true;

    # ── Fonts ──────────────────────────────────────────────────────────
    fonts = {
      general    = { family = "Inter"; pointSize = 13; };
      menu       = { family = "Inter"; pointSize = 13; };
      toolbar    = { family = "Inter"; pointSize = 13; };
      small      = { family = "Inter"; pointSize = 10; };
      fixedWidth = { family = "JetBrains Mono"; pointSize = 12; };
    };

    # ── Window Decorations ─────────────────────────────────────────────
    kwin = {
      titlebarButtons.left  = [];
      titlebarButtons.right = [ "minimize" "maximize" "close" ];
      effects = {
        wobblyWindows.enable       = false;
        desktopSwitching.animation = "slide";
      };
    };

    # ── Theme ──────────────────────────────────────────────────────────
    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop";
      colorScheme = "BreezeDark";
      iconTheme   = "Papirus-Dark";
      cursor      = { theme = "breeze_cursors"; size = 24; };
    };

    # ── Shortcuts ─────────────────────────────────────────────────────
    shortcuts = {
      kwin = {
        "Overview"                        = [];
        "Grid View"                       = "Meta+G";
        "Kill Window"                     = "Meta+Ctrl+Esc";
        "Show Desktop"                    = "Meta+D";
        "Walk Through Windows"            = [ "Meta+Tab" "Alt+Tab" ];
        "Walk Through Windows (Reverse)"  = [ "Meta+Shift+Tab" "Alt+Shift+Tab" ];
        "Window Close"                    = "Alt+F4";
        "Window Maximize"                 = "Meta+PgUp";
        "Window Minimize"                 = "Meta+PgDown";
        "Window Quick Tile Left"          = "Meta+Left";
        "Window Quick Tile Right"         = "Meta+Right";
        "Window Quick Tile Top"           = "Meta+Up";
        "Window Quick Tile Bottom"        = "Meta+Down";
        "Window One Desktop to the Left"  = "Meta+Ctrl+Shift+Left";
        "Window One Desktop to the Right" = "Meta+Ctrl+Shift+Right";
        "Window to Next Screen"           = "Meta+Shift+Right";
        "Window to Previous Screen"       = "Meta+Shift+Left";
        "Switch One Desktop to the Left"  = "Meta+Ctrl+Left";
        "Switch One Desktop to the Right" = "Meta+Ctrl+Right";
      };
      ksmserver = {
        "Lock Session" = [ "Meta+L" "Screensaver" ];
        "Log Out"      = "Ctrl+Alt+Del";
      };
      plasmashell = {
        "activate application launcher" = [ "Meta" "Alt+F1" ];
        "activate task manager entry 1" = "Meta+1";
        "activate task manager entry 2" = "Meta+2";
        "activate task manager entry 3" = "Meta+3";
        "activate task manager entry 4" = "Meta+4";
        "activate task manager entry 5" = "Meta+5";
        "activate task manager entry 6" = "Meta+6";
        "activate task manager entry 7" = "Meta+7";
        "activate task manager entry 8" = "Meta+8";
        "activate task manager entry 9" = "Meta+9";
      };
    };

    # ── Config ────────────────────────────────────────────────────────
    configFile = {
      # Scrollen
      "kcminputrc"."Libinput"."NaturalScroll" = false;
      "kcminputrc"."Libinput/1739/52620/SYNA8007:00 06CB:CD8C Touchpad"."NaturalScroll" = true;
      "kcminputrc"."Mouse"."cursorSize" = 24;

      # KWin Effects
      "kwinrc"."Effect-overview"."BorderActivate"   = 9;
      "kwinrc"."Effect-windowview"."BorderActivate" = 9;
      "kwinrc"."Plugins"."windowviewEnabled"        = false;
      "kwinrc"."Plugins"."wobblywindowsEnabled"     = false;
      "kwinrc"."Plugins"."fadedesktopEnabled"       = false;
      "kwinrc"."Plugins"."slideEnabled"             = true;
      "kwinrc"."Plugins"."appmenuEnabled"           = false;
      "kwinrc"."Tiling"."padding"                   = 4;

      # Performance
      "kwinrc"."Compositing"."Enabled"                 = true;
      "kwinrc"."Compositing"."Backend"                 = "OpenGL";
      "kwinrc"."Compositing"."GLCore"                  = true;
      "kwinrc"."Compositing"."LatencyPolicy"           = "Low";
      "kwinrc"."Compositing"."MaxFPS"                  = 60;
      "kwinrc"."Compositing"."WindowsBlockCompositing" = false;

      # Klassy Decoration
      "kwinrc"."org.kde.kdecoration2"."library" = "org.kde.klassy";

      # Klassy – macOS Ampel-Farben
      "klassyrc"."Windeco"."ButtonIconStyle"         = "3";
      "klassyrc"."Windeco"."ButtonShape"             = "2";
      "klassyrc"."Windeco"."CloseButtonIconColor"    = "#ed6a5e";
      "klassyrc"."Windeco"."MinimizeButtonIconColor" = "#f5bf4f";
      "klassyrc"."Windeco"."MaximizeButtonIconColor" = "#62c554";
      "klassyrc"."Windeco"."ActiveButtonIconColor"   = "#000000";

      # Sonstiges
      "kwalletrc"."Wallet"."First Use"   = false;
      "plasma-localerc"."Formats"."LANG" = "en_US.UTF-8";
    };

    # ── Panels ────────────────────────────────────────────────────────
    panels = [
      # Taskleiste oben – Programme + Desktop-Switcher
      {
        location = "top";
        floating  = false;
        height    = 32;
        widgets = [
          {
            name = "org.kde.plasma.kickoff";
            config.General = {
              icon           = "nix-snowflake";
              showAppsByName = "true";
              showRecentDocs = "false";
            };
          }
          "org.kde.plasma.pager"
          {
            name = "org.kde.plasma.icontasks";
            config.General = {
              launchers              = "applications:librewolf.desktop";
              showOnlyCurrentScreen  = "false";
              showOnlyCurrentDesktop = "true";
              iconSize               = "2";
              fill                   = "true";
            };
          }
          "org.kde.plasma.panelspacer"
          "org.kde.plasma.systemtray"
          {
            name = "org.kde.plasma.digitalclock";
            config.Appearance = {
              showDate     = "true";
              use24hFormat = "2";
            };
          }
        ];
      }
      # Kein unterer Dock mehr – Programme sind oben
    ];
  };

  # ── Pakete ────────────────────────────────────────────────────────
  home.packages = with pkgs; [
    inter
    jetbrains-mono
    papirus-icon-theme
  ];
}