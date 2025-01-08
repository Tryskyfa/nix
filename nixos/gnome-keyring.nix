{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    libsecret
    gcr
  ];
  services.gnome.gnome-keyring.enable = true;
  # auto decrypt on login
  security.pam.services.greetd.enableGnomeKeyring = true;
  programs.seahorse.enable = true;
  programs.ssh.enableAskPassword = true;
}
