{
  description = "Modulares Multi-System Flake nach Github-Vorlage";

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

  outputs = { self, nixpkgs, home-manager, firefox-addons, ... } @ inputs:
  let
    system = "x86_64-linux";
    userName = "awiesner";

    mkHost = hostName: nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs userName; };
      modules = [
        ./configuration.nix
        ./hosts/${hostName}/default.nix
        ./homeModules/homemanager.nix
        {
          nixpkgs.config.allowUnfree = true;
          nixpkgs.overlays = [ inputs.nix-vscode-extensions.overlays.default ];
        }
      ];
    };

    hosts = [
      "nixos-laptop"
      "nixos-anaconda"
    ];
  in {
    nixosConfigurations = builtins.listToAttrs (
      map (host: {
        name = host;
        value = mkHost host;
      }) hosts
    );
  };
}