# awiesner-bookmarks.nix
[
  {
    name = "toolbar";
    toolbar = true;
    bookmarks = [
      {
        name = "Packages";
        url = "https://search.nixos.org/packages";
        tags = [ "nixos" "packete" ];
      }
      {
        name = "Manual";
        url = "https://nixos.org/manual/nixos/stable/";
        tags = [ "nixos" "wiki" ];
        keyword = "nwiki";
      }
    ];
  }
]
