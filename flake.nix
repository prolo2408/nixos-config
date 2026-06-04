{
  description = "A very basic flake";

  inputs = {
    # Du nutzt hier 'nixos-unstable', das ist absolut fein (Rolling Release)
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs:
    let 
      system = "x86_64-linux";
      
      # Eine Funktion, die uns die Konfiguration für ein System baut
      mkHost = hostName: nixpkgs.lib.nixosSystem {
        inherit system;
        
        # Damit kannst du 'inputs' oder 'home-manager' in configuration.nix nutzen
        specialArgs = { inherit inputs; };
        
        modules = [
          ./configuration.nix
          ./packages.nix
          ./hosts/${hostName}/default.nix # Lädt den PC-spezifischen Ordner

          # HIER GEHÖRT DER HOME-MANAGER HIN: Als Modul für jedes System
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.awiesner = import ./home.nix;
          }
        ];
      };

      # Die Liste deiner PCs
      hosts = [
        "nixos-laptop"
        "nixos-anaconda"
      ];

    in {
      # Standard-Pakete (wurden aus deinem Template übernommen)
      packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;
      packages.x86_64-linux.default = self.packages.x86_64-linux.hello;

      # Hier generieren wir dynamisch das Attribut-Set für deine PCs
      nixosConfigurations = builtins.listToAttrs (
        map (host: {
          name = host;
          value = mkHost host;
        }) hosts
      );
    };
}