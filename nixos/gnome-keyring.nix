{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    gnome-keyring
    seahorse
    libsecret
  ];
  services.gnome.gnome-keyring.enable = true;
  # auto decrypt on login
  # security.pam.services.*.enableGnomeKeyring = true;
}
