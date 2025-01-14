{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "tryskyfa";
  home.homeDirectory = "/home/tryskyfa";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # misc
  home.packages = with pkgs; [
    gcc
    xclip
    lazygit
    imagemagick
    tree
    noto-fonts
    htop
    btop
    pavucontrol
  ];

  imports = [
    ./zsh/zsh.nix
    ./nvim/nvim.nix
    ./sway/sway.nix
    ./sway/kanshi.nix
    ./waybar/waybar.nix
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "firefox";
    MANPAGER = "nvim +Man!";
    SSH_ASKPASS = ''${pkgs.seahorse}/libexec/seahorse/ssh-askpass'';
    GIT_ASKPASS = ''${pkgs.seahorse}/libexec/seahorse/ssh-askpass'';
    SSH_ASKPASS_REQUIRE = "prefer";
    # used by gnome-keyring, there is probably a better solution but this works
    SSH_AUTH_SOCK = "/run/user/1000/keyring/ssh";
  };
}
