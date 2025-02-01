{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    nvd
    nix-output-monitor
  ];
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      dates = "weekly";
      extraArgs = "--keep 5 --keep-since 3d";
    };
    flake = "/home/tryskyfa/nix";

  };
}
