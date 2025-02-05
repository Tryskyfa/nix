{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    font-awesome
    networkmanagerapplet
  ];
  programs.waybar.enable = true;

  programs.waybar.style = ''
    ${builtins.readFile ./style.css}
  '';
  programs.waybar.settings = {
    mainBar = {

      # "layer": "top", // Waybar at top layer
      # "position": "bottom", // Waybar position (top|bottom|left|right)
      height = 30; # Waybar height (to be removed for auto height)
      # "width": 1280, // Waybar width
      spacing = 4; # Gaps between modules (4px)
      # Choose the order of the modules
      modules-left = [
        "sway/workspaces"
        "sway/scratchpad"
      ];
      modules-center = [
        # "sway/window"
      ];
      modules-right = [
        # "mpd"
        "idle_inhibitor"
        "power-profiles-daemon"
        "pulseaudio"
        "network"
        "cpu"
        "memory"
        "temperature"
        "backlight"
        "keyboard-state"
        "battery"
        "clock"
        "tray"
      ];
      # Modules configuration
      # "sway/workspaces": {
      #     "disable-scroll": true,
      #     "all-outputs": true,
      #     "warp-on-scroll": false,
      #     "format": "{name}: {icon}",
      #     "format-icons": {
      #         "1": "",
      #         "2": "",
      #         "3": "",
      #         "4": "",
      #         "5": "",
      #         "urgent": "",
      #         "focused": "",
      #         "default": ""
      #     }
      # },
      keyboard-state = {
        capslock = true;
        format = "{name} {icon}";
        format-icons = {
          locked = " ";
          unlocked = " ";
        };
      };
      "sway/mode" = {
        format = "<span style=\"italic\">{}</span>";
      };
      "sway/scratchpad" = {
        format = "{icon} {count}";
        show-empty = false;
        format-icons = [
          ""
          " "
        ];
        tooltip = true;
        tooltip-format = "{app}: {title}";
      };
      # mpd = {
      #   format = "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {album} - {title} ({elapsedTime =%M:%S}/{totalTime:%M:%S}, ⸨{songPosition}|{queueLength}⸩ {volume}% ";
      #   format-disconnected = "Disconnected ";
      #   format-stopped = "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped ";
      #   unknown-tag = "N/A";
      #   interval = 5;
      #   consume-icons = {
      #     on = " ";
      #   };
      #   random-icons = {
      #     off = "<span color=\"#f53c3c\"></span> ";
      #     on = " ";
      #   };
      #   repeat-icons = {
      #     on = " ";
      #   };
      #   single-icons = {
      #     on = "1 ";
      #   };
      #   state-icons = {
      #     paused = "";
      #     playing = "";
      #   };
      #   tooltip-format = "MPD (connected)";
      #   tooltip-format-disconnected = "MPD (disconnected)";
      # };
      idle_inhibitor = {
        format = "{icon}";
        format-icons = {
          activated = "󰒳 ";
          deactivated = "󰒲 ";
        };
      };
      tray = {
        # "icon-size": 21,
        spacing = 10;
      };
      clock = {
        timezone = "Europe/Berlin";
        format = "{:%F %R  }";
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        calendar = {
          mode = "year";
          mode-mon-col = 3;
          weeks-pos = "right";
          on-scroll = 1;
          on-click-right = "mode";
          format = {
            months = "<span color='#ff79c6'><b>{}</b></span>";
            days = "<span color='#f8f8f2'><b>{}</b></span>";
            weeks = "<span color='#50fa7d'>W{}</span>";
            weekdays = "<span color='#ffb86c'><b>{}</b></span>";
            today = "<span color='#f1fa8c'><b><u>{}</u></b></span>";
          };
        };
        actions = {
          on-click-right = "mode";
          on-click-forward = "tz_up";
          on-click-backward = "tz_down";
          on-scroll-up = "shift_up";
          on-scroll-down = "shift_down";
        };

      };
      cpu = {
        format = "{usage}%  ";
        tooltip = false;
      };
      memory = {
        format = "{}%  ";
      };
      temperature = {
        thermal-zone = 1;
        critical-threshold = 80;
        format-critical = "{temperatureC}°C {icon}";
        format = "{temperatureC}°C {icon}";
        format-icons = [
          ""
          ""
          ""
        ];
      };
      backlight = {
        # "device": "acpi_video1",
        format = "{percent}% {icon}";
        format-icons = [
          " "
          " "
          " "
          " "
          " "
          " "
          " "
          " "
          " "
        ];
      };
      battery = {
        states = {
          # "good": 95,
          warning = 30;
          critical = 15;
        };
        format = "{capacity}% {icon}";
        format-full = "{capacity}% {icon}";
        format-charging = "{capacity}% ";
        format-plugged = "{capacity}% ";
        format-alt = "{time} {icon}";
        # "format-good": "", // An empty format will hide the module
        # "format-full": "",
        format-icons = [
          " "
          " "
          " "
          " "
          " "
        ];
      };
      power-profiles-daemon = {
        format = "{icon}";
        tooltip-format = "Power profile: {profile}\nDriver: {driver}";
        tooltip = true;
        format-icons = {
          default = "";
          performance = "";
          balanced = " ";
          power-saver = " ";
        };
      };
      network = {
        # "interface": "wlp2*", // (Optional) To force the use of this interface
        format-wifi = "{essid} ({signalStrength}%) ";
        format-ethernet = "{ipaddr}/{cidr} ";
        tooltip-format = "{ifname} via {gwaddr} ";
        format-linked = "{ifname} (No IP) ";
        format-disconnected = "Disconnected ⚠";
        format-alt = "{ifname}: {ipaddr}/{cidr}";
      };
      pulseaudio = {
        # "scroll-step": 1, // %, can be a float
        format = "{volume}% {icon} {format_source}";
        format-bluetooth = "{volume}% {icon} {format_source}";
        format-bluetooth-muted = " {icon} {format_source}";
        format-muted = " {format_source}";
        format-source = "{volume}% ";
        format-source-muted = "";
        format-icons = {
          headphone = "";
          hands-free = "";
          headset = "";
          phone = "";
          portable = "";
          car = "";
          default = [
            ""
            ""
            ""
          ];
        };
        on-click = "pavucontrol";
      };
    };
  };
}
