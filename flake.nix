{
  description = "root flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix/release-24.11";

    plugin-lazydev.url = "github:folke/lazydev.nvim";
    plugin-lazydev.flake = false;
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      stylix,
      ...
    }:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;

        config = {
          allowUnfree = true;
        };
      };
    in
    {
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit system; };

          modules = [
            ./hosts/desktop/configuration.nix
            # needed to enable sway on a user level
            ./nixos/user_wm.nix
            ./nixos/gnome-keyring.nix
            ./nixos/greeter.nix
            ./nixos/xdg.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.tryskyfa = import ./home/home.nix;
            }
            stylix.nixosModules.stylix
            ./stylix/stylix.nix
          ];
        };
        laptop = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit system; };

          modules = [
            ./hosts/laptop/configuration.nix
            # needed to enable sway on a user level
            ./nixos/user_wm.nix
            ./nixos/gnome-keyring.nix
            ./nixos/greeter.nix
            ./nixos/xdg.nix
            ./nixos/bluetooth.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.tryskyfa = import ./home/home.nix;
            }
            stylix.nixosModules.stylix
            ./stylix/stylix.nix
          ];
        };
      };
    };
}
