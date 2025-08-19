{ pkgs, ... }:
{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      opener = {
        edit = [
          {
            run = "nvim \"$@\"";
            block = true;
          }
        ];
        xopp = [
          {
            run = "${pkgs.xournalpp}/bin/xournalpp \"$@\"";
            block = false;
          }
        ];
      };
      open = {
        prepend_rules = [
          {
            name = "*.xopp";
            use = "xopp";
          }
        ];
      };
    };
  };
}
