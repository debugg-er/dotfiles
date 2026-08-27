{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    multiverse.url = "github:fzakaria/nixpkgs-multiverse";
  };

  outputs = { self, nixpkgs, nixos-wsl, multiverse, ... }: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = {
          inherit multiverse;
        };

        modules = [
          nixos-wsl.nixosModules.default
          ./configuration.nix
        ];
      };
    };
  };
}
