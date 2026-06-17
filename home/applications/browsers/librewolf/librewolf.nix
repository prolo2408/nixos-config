{ lib, config, pkgs, inputs, ... }:

let
  bookmarks = import ../bookmarks.nix;
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
    };

    profiles.default = {
      id = 0;
      isDefault = true;

      settings = {
        "browser.toolbars.bookmarks.visibility" = "always";

        # Dark mode
        "ui.systemUsesDarkTheme" = 0;
        "browser.theme.content-theme" = 0;
        "browser.theme.toolbar-theme" = 0;
        "layout.css.prefers-color-scheme.content-override" = 0;
        "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
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

      extensions = {
        packages = with inputs.firefox-addons.packages.${pkgs.system}; [
          bitwarden
          ublock-origin
          darkreader
        ];
      };
    };
  };
}
