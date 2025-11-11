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
    noto-fonts
    htop
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
    llvmPackages_19.llvm-manpages
    llvmPackages_19.clang-manpages
    man-pages-posix
    man-pages
    gnumake
    unzip
    qrencode
    exiftool
    rofimoji
    wev
    diffpdf
    bitwarden
    usbutils
    R
    onlyoffice-desktopeditors
    openvpn
    cifs-utils
    samba
    discord
    feh
    gnome-sound-recorder
    chromium
    pdftk
    typst
    ghc
    wl-mirror
    anki
    rnote
    python313
    inkscape
    lean4
    (pkgs.stdenvNoCC.mkDerivation {
      pname = "my-fonts";
      version = "1.0";
      src = ./fonts;
      installPhase = ''
        mkdir -p $out/share/fonts
        cp *.otf $out/share/fonts
        cp *.ttf $out/share/fonts
      '';
    })
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
    ./eza.nix
    ./hyprlock.nix
    ./btop.nix
    ./nix-shell.nix
    ./vscode.nix
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

  xdg.desktopEntries.feh = {
    name = "feh";
    exec = "${pkgs.feh}/bin/feh %F";
    icon = "image";
    terminal = false;
    type = "Application";
    mimeType = [
      "image/png"
      "image/jpeg"
    ];
  };
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = [
        "org.pwmt.zathura-pdf-mupdf.desktop"
      ];
      "image/png" = [ "feh.desktop" ];
      "image/jpeg" = [ "feh.desktop" ];
      "text/plain" = [ "nvim.desktop" ];
      "application/x-xopp" = [ "com.github.xournalpp.xournalpp.desktop" ];
      "x-scheme-handler/http" = [ "firefox.desktop" ];
      "x-scheme-handler/https" = [ "firefox.desktop" ];
      "x-scheme-handler/chrome" = [ "firefox.desktop" ];
      "text/html" = [ "firefox.desktop" ];
      "application/x-extension-htm" = [ "firefox.desktop" ];
      "application/x-extension-html" = [ "firefox.desktop" ];
      "application/x-extension-shtml" = [ "firefox.desktop" ];
      "application/xhtml+xml" = [ "firefox.desktop" ];
      "application/x-extension-xhtml" = [ "firefox.desktop" ];
      "application/x-extension-xht" = [ "firefox.desktop" ];
      "x-scheme-handler/sgnl" = [ "signal.desktop" ];
      "x-scheme-handler/signalcaptcha" = [ "signal.desktop" ];
    };
    associations.added = {
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/chrome" = "firefox.desktop";
      "text/html" = "firefox.desktop";
      "application/x-extension-htm" = "firefox.desktop";
      "application/x-extension-html" = "firefox.desktop";
      "application/x-extension-shtml" = "firefox.desktop";
      "application/xhtml+xml" = "firefox.desktop";
      "application/x-extension-xhtml" = "firefox.desktop";
      "application/x-extension-xht" = "firefox.desktop";
    };
  };
  fonts.fontconfig.enable = true;
}
