{ config, pkgs, ... }:
{
  imports = [
    ./waybar.nix
  ];
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
          { command = "nm-applet"; }
        ];
        bars = [
          {
            command = "${pkgs.waybar}/bin/waybar";
          }
        ];

        keybindings = {
          "${mod}+Return" = "exec kitty";
          "${mod}+w" = "kill";
          "Alt+space" = "exec ${pkgs.rofi}/bin/rofi -show combi -config ~/.config/rofi/config.rasi";
          "${mod}+h" = "focus left";
          "${mod}+j" = "focus down";
          "${mod}+k" = "focus up";
          "${mod}+l" = "focus right";
          "${mod}+Shift+h" = "move left";
          "${mod}+Shift+j" = "move down";
          "${mod}+Shift+k" = "move up";
          "${mod}+Shift+l" = "move right";
          "${mod}+r" = "splith";
          "${mod}+d" = "splitv";
          "${mod}+f" = "fullscreen toggle";
          "${mod}+e" = "layout toggle split";
          "${mod}+t" = "layout toggle split tabbed";
          "${mod}+Shift+space" = "floating toggle";
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
          "${mod}+p" = "focus prev";
          "${mod}+n" = "focus next";
          "${mod}+Escape" =
            "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";
          "${mod}+Right" = "resize grow width 2";
          "${mod}+Left" = "resize shrink width 2";
          "${mod}+Up" = "resize shrink height 2";
          "${mod}+Down" = "resize grow height 2";
        };
      };

      extraConfigEarly = ''
        # give sway a little time to startup before starting kanshi.
        exec sleep 5; systemctl --user start kanshi.service
        exec_always /run/wrappers/bin/gnome-keyring-daemon --start --daemonize
      '';

      extraConfig = ''
        input * repeat_delay 200
        input * repeat_rate 40
        ${builtins.readFile ./catppuccin-macchiato}
        # target                 title     bg    text   indicator  border
        client.focused           $lavender $base $text  $rosewater $lavender
        client.focused_inactive  $overlay0 $base $text  $rosewater $overlay0
        client.unfocused         $overlay0 $base $text  $rosewater $overlay0
        client.urgent            $peach    $base $peach $overlay0  $peach
        client.placeholder       $overlay0 $base $text  $overlay0  $overlay0
        client.background        $base
      '';
    };
}
