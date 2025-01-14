{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    font-awesome
    networkmanagerapplet
  ];
  programs.waybar.enable = true;

}
