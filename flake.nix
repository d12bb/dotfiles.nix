{
  description = "d12bb's dotfiles";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    darwin,
    home-manager,
    rust-overlay,
    ...
  } @ inputs: {
    devShell.aarch64-darwin = with nixpkgs.legacyPackages.aarch64-darwin;
      mkShell {
        buildInputs = [
          pkgs.nil
        ];
      };
    formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.alejandra;

    darwinConfigurations."Benedikts-MBP" = darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        ./macos.nix
        home-manager.darwinModules.home-manager
        {
          home-manager.backupFileExtension = "bak";
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.bene = import ./home-manager.nix;
        }
        ({pkgs, ...}: {
          nixpkgs.overlays = [rust-overlay.overlays.default];
          environment.systemPackages = [pkgs.rust-bin.stable.latest.default];
        })
      ];
    };
  };
}
