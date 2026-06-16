# Bindeglied zwischen NixOS und Home-Manager.
{ inputs, userName, ... }:

{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit inputs userName; };

    # plasma-manager steht allen Home-Profilen zur Verfügung.
    sharedModules = [ inputs.plasma-manager.homeModules.plasma-manager ];

    # Basis-Home (Desktop-unabhängig). Das DE-spezifische Home-Modul
    # (Plasma bzw. Hyprland) ergänzt der jeweilige Host – siehe hosts/<name>/default.nix.
    users.${userName} = {
      imports = [ ./default.nix ];
    };
  };

  programs.dconf.enable = true;
}
