{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs } @ inputs:

    let 
      system = "x86_64-linux";
      
      mkHost = 
        hostName:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = inputs // {
   	    inherit inputs;
	  };
	  modules = [
	    ./configuration.nix
	    ./packages.nix
	    ./hosts/${hostName}/default.nix
	  ];
	};

	hosts = [
	  "nixos-laptop"
	  "nixos-anaconda"
	];

    in
    {
      packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;
      packages.x86_64-linux.default = self.packages.x86_64-linux.hello;

      nixosConfigurations = builtins.listToAttrs (
	map (host: {
	  name = host;
	  value = mkHost host;
	}) hosts
    );
  };
}
