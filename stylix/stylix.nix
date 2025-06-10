{ pkgs, ... }:
{
  stylix = {
    enable = true;
    image = ./background.jpg;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/dracula.yaml";
    polarity = "dark";

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 22;
    };

    fonts.monospace = {
      name = "DejaVuSansMNerdFont-Regular";
      package = pkgs.nerd-fonts.dejavu-sans-mono;
    };
  };
}
