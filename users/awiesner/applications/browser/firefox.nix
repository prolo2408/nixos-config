{ config, pkgs, inputs, ... }:
{
  programs.browserpass.enable = true;
  programs.firefox = {
    enable = true;

    profiles.awiesner = {

      id = 0;

      bookmarks = import ./awiesner-bookmarks.nix;

      settings = {
          "browser.toolbars.bookmarks.visibility" = "always"; # Zeigt die Symbolleiste dauerhaft an
        };

      extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
        bitwarden
        ublock-origin
      ];
    };
  };
}   