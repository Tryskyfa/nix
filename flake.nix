{
  description = "root flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix/release-25.11";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      stylix,
      ...
    }:
    let
      system = "x86_64-linux";
      overlay-unstable = final: prev: {
        vimPlugins.lean-nvim = (import nixpkgs-unstable { inherit system; }).vimPlugins.lean-nvim;
      };
      pkgs = import nixpkgs {
        inherit system;

        config = {
          allowUnfree = true;
        };
        overlays = [
          overlay-unstable
        ];
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
            ./nixos/playerctl.nix
            ./nixos/local_time.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.tryskyfa = import ./home/home.nix;
              home-manager.extraSpecialArgs = {
                host = "desktop";
              };
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
            ./nixos/playerctl.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.tryskyfa = import ./home/home.nix;
              home-manager.extraSpecialArgs = {
                host = "laptop";
              };
            }
            stylix.nixosModules.stylix
            ./stylix/stylix.nix
          ];
        };
      };
    };
}
