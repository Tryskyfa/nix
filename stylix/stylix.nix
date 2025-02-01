{ pkgs, ... }:
{
  stylix.enable = true;
  stylix.image = ./background.jpg;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/dracula.yaml";
  stylix.polarity = "dark";
}
