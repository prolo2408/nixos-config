{ lib, config, pkgs, inputs, ... }:

let
  bookmarks = import ../bookmarks.nix;
in

{
  programs.browserpass.enable = true;

  programs.firefox = {
    enable = true;

    profiles.default = {
      id = 0;
      isDefault = true;

      settings = {
        "browser.toolbars.bookmarks.visibility" = "always";
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
        ];
      };
    };
  };
}
