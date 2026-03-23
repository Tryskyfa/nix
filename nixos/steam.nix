{
  pkgs,
  ...
}:
{
  programs.steam = {
    enable = true;
  };
  environment.systemPackages = with pkgs; [
    steam-run
  ];
  programs.steam.extraCompatPackages = with pkgs; [
    proton-ge-bin
  ];
}
