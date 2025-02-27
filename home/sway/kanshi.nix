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
        profile.name = "desktop-normal";
        profile.outputs = [
          {
            criteria = "Dell Inc. AW2521HFA 7LZXL03";
            position = "0,0";
            mode = "1920x1080@119.982Hz";
          }
          {
            criteria = "AOC 2460G5 0x0000D3A1";
            position = "1920,0";
            mode = "1920x1080@60Hz";
          }
        ];
      }
      {
        profile.name = "laptop-docked";
        profile.outputs = [
          {
            criteria = "LG Display 0x06ED Unknown";
            status = "disable";
          }
          {
            criteria = "Dell Inc. AW2521HFA 7LZXL03";
            position = "0,0";
            mode = "1920x1080@119.982Hz";
          }
          {
            criteria = "AOC 2460G5 GKAH9HA054177";
            position = "1920,0";
            mode = "1920x1080@60Hz";
          }
        ];
      }
      {
        profile.name = "laptop-normal";
        profile.outputs = [
          {
            criteria = "LG Display 0x06ED Unknown";
            status = "enable";
            position = "0,0";
            mode = "1920x1200@60.001Hz";
          }
        ];
      }
    ];
  };
}
