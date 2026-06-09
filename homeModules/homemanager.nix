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

    # Gibt inputs und userName an deine users/awiesner/default.nix weiter
    extraSpecialArgs = { inherit inputs userName; };

    # Lädt deine Benutzerdatei
    users.${userName} = import ../users/${userName}/default.nix;
  };

  programs.dconf.enable = true;
}