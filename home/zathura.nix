{ pkgs, ... }:
{
  programs.zathura = {
    enable = true;
    extraConfig = ''
      set selection-clipboard clipboard
      map _ zoom out
    '';
  };
}
