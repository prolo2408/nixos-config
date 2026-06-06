{
  description = "Modulares Multi-System Flake nach Github-Vorlage";

  inputs = {
    # Korrigierte URL für die stabile Version 25.11
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, firefox-addons, ... } @ inputs:
    let 
      system = "x86_64-linux";
      
      # Dein Username wird hier EINMAL zentral definiert und an alle Module gereicht
      userName = "awiesner";
      
      # Die modulare Funktion zum Bauen der PCs
      mkHost = hostName: nixpkgs.lib.nixosSystem {
        inherit system;
        
        # Hier übergeben wir die inputs UND den userName sauber als Argumente (specialArgs)
        # Das verhindert die "infinite recursion"-Fehler in der homemanager.nix!
        specialArgs = { inherit inputs userName; };
        
        modules = [
          ./configuration.nix
          ./hosts/${hostName}/default.nix
          ./homeModules/homemanager.nix
        ];
      };

      hosts = [
        "nixos-laptop"
        "nixos-anaconda"
      ];

    in {
      # Generiert vollautomatisch die Konfigurationen für deine PCs aus der hosts-Liste
      nixosConfigurations = builtins.listToAttrs (
        map (host: {
          name = host;
          value = mkHost host;
        }) hosts
      );
    };
}
