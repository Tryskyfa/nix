{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    rofi
  ];
  wayland.windowManager.sway =
    let
      mod = "Mod4";
    in
    {
      enable = true;
      extraOptions = [
        "--unsupported-gpu"
      ];
      wrapperFeatures.gtk = true; # Fixes common issues with GTK 3 apps
      config = rec {
        modifier = mod;
        # Use kitty as default terminal
        terminal = "kitty";
        startup = [
        ];

        keybindings = {
          "${mod}+Return" = "exec kitty";
          "${mod}+Shift+q" = "kill";
          "${mod}+d" = "exec ${pkgs.rofi}/bin/rofi -show combi -config ~/.config/rofi/config.rasi";
          "${mod}+h" = "focus left";
          "${mod}+j" = "focus down";
          "${mod}+k" = "focus up";
          "${mod}+l" = "focus right";
          "${mod}+Shift+h" = "move left";
          "${mod}+Shift+j" = "move down";
          "${mod}+Shift+k" = "move up";
          "${mod}+Shift+l" = "move right";
          "${mod}+s" = "splith";
          "${mod}+v" = "splitv";
          "${mod}+f" = "fullscreen toggle";
          "${mod}+w" = "layout stacking";
          "${mod}+t" = "layout tabbed";
          "${mod}+e" = "layout toggle split";
          "${mod}+Shift+space" = "floating toggle";
          "${mod}+space" = "focus mode_toggle";
          "${mod}+1" = "workspace number 1";
          "${mod}+2" = "workspace number 2";
          "${mod}+3" = "workspace number 3";
          "${mod}+4" = "workspace number 4";
          "${mod}+5" = "workspace number 5";
          "${mod}+6" = "workspace number 6";
          "${mod}+7" = "workspace number 7";
          "${mod}+8" = "workspace number 8";
          "${mod}+9" = "workspace number 9";
          "${mod}+0" = "workspace number 10";
          "${mod}+Shift+1" = "move container to workspace number 1";
          "${mod}+Shift+2" = "move container to workspace number 2";
          "${mod}+Shift+3" = "move container to workspace number 3";
          "${mod}+Shift+4" = "move container to workspace number 4";
          "${mod}+Shift+5" = "move container to workspace number 5";
          "${mod}+Shift+6" = "move container to workspace number 6";
          "${mod}+Shift+7" = "move container to workspace number 7";
          "${mod}+Shift+8" = "move container to workspace number 8";
          "${mod}+Shift+9" = "move container to workspace number 9";
          "${mod}+Shift+0" = "move container to workspace number 10";
          "${mod}+Shift+r" = "reload";
          "${mod}+Shift+e" =
            "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";
          "${mod}+r" = "mode resize";
        };
      };

      extraConfigEarly = ''
        # give sway a little time to startup before starting kanshi.
        exec sleep 5; systemctl --user start kanshi.service
        exec_always eval $(/run/wrappers/bin/gnome-keyring-daemon --start --daemonize)
      '';

      extraConfig = ''
        input * repeat_delay 200
        input * repeat_rate 40
      '';
    };
}
