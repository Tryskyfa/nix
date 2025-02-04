{ config, pkgs, ... }:
{
  stylix.targets.fzf.enable = false;
  programs.fzf = {
    enable = true;
    changeDirWidgetCommand = "fd --type d";
    fileWidgetCommand = "fd --type file --base-directory ~ --absolute-path";
    colors = {
      fg = "-1";
      bg = "-1";
      hl = "#5fff87";
      "fg+" = "-1";
      "bg+" = "-1";
      "hl+" = "#ffaf5f";
      info = "#af87ff";
      prompt = "#5fff87";
      pointer = "#ff87d7";
      marker = "#ff87d7";
      spinner = "#ff87d7";
    };
    tmux.enableShellIntegration = true;
  };
}
