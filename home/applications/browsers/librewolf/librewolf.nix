{ lib, config, pkgs, inputs, ... }:

let
  bookmarks = import ../bookmarks.nix;
  extensions = import ./extensions.nix { inherit pkgs inputs; };
in

{
  programs.browserpass.enable = true;

  programs.librewolf = {
    enable = true;

    # Replace the built-in DuckDuckGo engine with one that forces dark mode
    # via the documented "kae=d" theme parameter (see duckduckgo.com/params),
    # so it stays dark regardless of cookies being cleared on shutdown.
    policies = {
      SearchEngines = {
        PreventInstalls = false;
        Remove = [ "Google" "Bing" "Amazon.com" "eBay" "Twitter" "Perplexity" "DuckDuckGo" ];
        Default = "DuckDuckGo (Dark)";
        Add = [
          {
            Name = "DuckDuckGo (Dark)";
            Description = "DuckDuckGo with dark theme forced via kae=d";
            Alias = "";
            Method = "GET";
            URLTemplate = "https://duckduckgo.com/?q={searchTerms}&kae=d";
            SuggestURLTemplate = "https://ac.duckduckgo.com/ac/?q={searchTerms}&type=list";
          }
        ];
      };

      DontCheckDefaultBrowser = true;
      HardwareAcceleration = true;
      PrintingEnabled = true;
      EncryptedMediaExtensions = true;
      DefaultDownloadDirectory = "\${home}/Downloads";
    };

    profiles.default = {
      id = 0;
      isDefault = true;

      settings = {
        "browser.toolbars.bookmarks.visibility" = "always";

        # Force websites that support a light/dark theme to render dark
        # (0 = force dark, 1 = force light, 2 = follow system theme).
        "layout.css.prefers-color-scheme.content-override" = 0;
        "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";

        # LibreWolf's default privacy.resistFingerprinting forces ALL sites
        # to report a light color scheme, overriding the pref above and
        # disabling the "Website appearance" setting entirely. Switch to the
        # granular fingerprintingProtection system instead, which gives the
        # same protections but lets us carve out the color-scheme signal so
        # native dark themes (not a content-filtering extension) actually work.
        "privacy.resistFingerprinting" = false;
        "privacy.fingerprintingProtection" = true;
        "privacy.fingerprintingProtection.overrides" = "+AllTargets,-CSSPrefersColorScheme";

        # Hardware video decoding
        "media.ffmpeg.vaapi.enabled" = true;
        "media.rdd-ffmpeg.enabled" = true;

        # Use the system certificate store (needed for custom/enterprise CAs)
        "security.enterprise_roots.enabled" = true;

        # DRM/EME support, required for streaming sites like Netflix/Spotify
        "media.eme.enabled" = true;
        "browser.eme.ui.enabled" = true;

        # JPEG XL image support
        "image.jxl.enabled" = true;

        # System integration on Linux
        "print.prefer_system_dialog" = true;
        "widget.use-xdg-desktop-portal.mime-handler" = 1;
        "widget.use-xdg-desktop-portal.file-picker" = 1;

        # Always show the full URL in the address bar
        "browser.urlbar.trimURLs" = false;

        # Ask before closing windows with multiple tabs
        "browser.tabs.warnOnClose" = true;

        # Navigate back/forward with backspace
        "browser.backspace_action" = 0;

        # Round reported window size to reduce fingerprinting surface
        "privacy.window.maxInnerWidth" = 2200;
        "privacy.window.maxInnerHeight" = 1200;

        # Always ask where to save downloads
        "browser.download.useDownloadDir" = false;
        "browser.download.alwaysOpenPanel" = true;
        "browser.download.manager.addToRecentDocs" = true;
        "browser.download.always_ask_before_handling_new_types" = true;

        # Auto-handle cookie consent banners
        "cookiebanners.service.mode" = 2;

        "general.autoScroll" = true;
        "middlemouse.paste" = false;
      };

      bookmarks = {
        force = true;
        settings = [
          {
            name = "toolbar";
            toolbar = true;
            bookmarks = bookmarks;
          }
        ];
      };

      containersForce = true;
      containers = {
        "Privat" = {
          id = 1;
          icon = "fingerprint";
          color = "blue";
        };
        "Schule" = {
          id = 2;
          icon = "briefcase";
          color = "orange";
        };
        "Shopping" = {
          id = 3;
          icon = "cart";
          color = "green";
        };
      };

      extensions.packages = extensions;
    };
  };
}
