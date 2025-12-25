{
  description = "System configuration flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    vgpu4nixos.url = "github:mrzenc/vgpu4nixos";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows =
        "nixpkgs"; # Ensure Home Manager uses the same nixpkgs version
    };

    mangowc.url = "github:DreamMaoMao/mangowc";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, vgpu4nixos, ... }: {

    overlays = import ./overlays { inherit inputs; };

    nixosModules = import ./modules/nixos;

    nixosConfigurations.Erasmus = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules =
        [ ./configuration.nix ./common/hypr.nix ./Erasmus/hw-config.nix ];
    };
    nixosConfigurations.Omnius = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        inputs.mangowc.nixosModules.mango
        { programs.mango.enable = true; }
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager = {
            backupFileExtension = "hm-backup";
            useGlobalPkgs = true;
            useUserPackages = true;
            users.kosan = ./kosan/home.nix;
          };
        }
        ./configuration.nix
        ./common/hypr.nix
        ./common/nvidia.nix
        ./Omnius/hw-config.nix
        ./Omnius/configuration.nix
        vgpu4nixos.nixosModules.host # host drivers
      ];
    };
  };
}
