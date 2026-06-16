{
  config,
  lib,
  pkgs,
  inputs,      # <--- Wir nutzen stattdessen die globalen inputs
  userName,
  ...
}:

{
  imports = [
    # Hier ziehen wir das Modul jetzt sauber aus den inputs heraus
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit inputs userName; };
    users.${userName} = import ./default.nix;
    sharedModules = [
    inputs.plasma-manager.homeManagerModules.plasma-manager
    ];
  };

  programs.dconf.enable = true;
}
