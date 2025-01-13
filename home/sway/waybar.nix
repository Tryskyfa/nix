{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    font-awesome
  ];
  programs.waybar.enable = true;

}
