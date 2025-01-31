{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    nvd
    nix-output-monitor
  ];
  programs.nh = {
    enable = true;
    clean.enable = true;
    flake = "/home/tryskyfa/nix";
  };
}
