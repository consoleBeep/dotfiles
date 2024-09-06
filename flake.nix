{
  description = "Top-level flake.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    stylix.url = "github:danth/stylix";
    hyprland.url = "github:hyprwm/Hyprland";
    nixcord.url = "github:kaylorben/nixcord";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {nixpkgs, ...} @ inputs: let
    inherit (builtins) attrNames readDir listToAttrs;

    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];

    hosts = attrNames (readDir ./hosts);
    forAllSystems = fn:
      nixpkgs.lib.genAttrs systems
      (system: fn {pkgs = import nixpkgs {inherit system;};});

    userInfo = {
      username = "bastian";
      email = "bastian@asmussen.tech";
      fullName = "Bastian Asmussen";
    };
  in {
    packages = forAllSystems ({pkgs}: import ./pkgs {inherit pkgs;});
    formatter = forAllSystems ({pkgs}: pkgs.alejandra);

    nixosConfigurations = listToAttrs (map (hostname: {
        name = hostname;
        value = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs userInfo;};
          modules = [
            ./hosts/${hostname}/configuration.nix
            ./modules/nixos

            {networking.hostName = hostname;}

            inputs.stylix.nixosModules.stylix
            inputs.disko.nixosModules.disko
          ];
        };
      })
      hosts);
  };
}
