{
  description = "System configuration flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = inputs@{ self, nixpkgs, ... }: {

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
        ./configuration.nix
        ./common/hypr.nix
        ./common/nvidia.nix
        ./Omnius/hw-config.nix
		./Omnius/configuration.nix
      ];
    };
  };
}
