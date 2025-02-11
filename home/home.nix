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
    lazygit
    wl-clipboard
    imagemagick
    tree
    noto-fonts
    htop
    btop
    pavucontrol
    fd
    xournalpp
    fastfetch
    element-desktop
    nextcloud-client
    orca-slicer
    gimp
    pom
    pferd
    signal-desktop
    grim
    slurp
    llvmPackages_19.clang-tools
    gnumake
    unzip
    qrencode
  ];

  imports = [
    ./zsh/zsh.nix
    ./nvim/nvim.nix
    ./sway/sway.nix
    ./sway/kanshi.nix
    ./waybar/waybar.nix
    ./fzf.nix
    ./fuzzel.nix
    ./nh.nix
    ./zathura.nix
    ./cliphist.nix
    ./yazi.nix
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

  xdg.desktopEntries.zathura = {
    name = "zathura";
    exec = "${pkgs.zathura}/bin/zathura";
  };
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = [
        "zathura.desktop"
        "firefox.desktop"
      ];
      "image/png" = [ "firefox.desktop" ];
      "image/jpg" = [ "firefox.desktop" ];
      "text/plain" = [ "nvim.desktop" ];
    };
  };
}
