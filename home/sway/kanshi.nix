{
  pkgs,
  ...
}:
{
  # kanshi systemd service
  services.kanshi = {
    enable = true;

    settings = [
      {
        profile.name = "normal";
        profile.outputs = [
          {
            criteria = "Dell Inc. AW2521HFA 7LZXL03";
            position = "0,0";
            mode = "1920x1080@239.757Hz";
          }
          {
            criteria = "AOC 2460G5 0x0000D3A1";
            position = "1920,0";
            mode = "1920x1080@60Hz";
          }
        ];
      }
    ];
  };
}
