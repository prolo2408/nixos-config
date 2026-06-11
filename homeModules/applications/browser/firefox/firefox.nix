{ config, pkgs, inputs, ... }:
{
  programs.browserpass.enable = true;
  programs.firefox = {
    enable = true;

    profiles.awiesner = {

      id = 0;

      bookmarks = import ./awiesner-bookmarks.nix;

      settings = {
          force = true;
          "browser.toolbars.bookmarks.visibility" = "always";
        };

      extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
        bitwarden
        ublock-origin
      ];
    };
  };
}
