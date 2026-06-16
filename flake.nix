{
  description = "Modulares Multi-Host NixOS-Flake (Home-Manager, KDE/Hyprland)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      userName = "awiesner";

      # Alle Maschinen. Der Verzeichnisname unter ./hosts MUSS dem
      # Eintrag hier und dem gesetzten networking.hostName entsprechen,
      # damit `nixos-rebuild switch --flake .#$(hostname)` funktioniert.
      hosts = [
        "nixos-laptop"
        "nixos-anaconda"
      ];

      mkHost =
        hostName:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs userName hostName; };
          modules = [
            ./modules/common.nix
            ./home/home-manager.nix
            ./hosts/${hostName}
          ];
        };
    in
    {
      # Erzeugt automatisch eine nixosConfiguration pro Eintrag in `hosts`.
      nixosConfigurations = nixpkgs.lib.genAttrs hosts mkHost;
    };
}
