{
  config,
  pkgs,
  lib,
  ...
}:
{
  home.packages = with pkgs; [
    swaybg
  ];
  wayland.windowManager.sway =
    let
      mod = "Mod4";
    in
    {
      enable = true;
      wrapperFeatures.gtk = true; # Fixes common issues with GTK 3 apps
      config = {
        modifier = mod;
        # Use kitty as default terminal
        terminal = "kitty";
        startup = [
          { command = "nm-applet"; }
          { command = "nextcloud"; }
        ];
        bars = [
          {
            command = "${pkgs.waybar}/bin/waybar";
          }
        ];

        keybindings = {
          "${mod}+Return" = "exec kitty";
          "${mod}+w" = "kill";
          "Alt+space" = "exec fuzzel --terminal=kitty";
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
          "${mod}+s" = "layout toggle split stacking";
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
          "${mod}+Escape" = "exec hyprlock";
          "${mod}+Right" = "resize grow width 2";
          "${mod}+Left" = "resize shrink width 2";
          "${mod}+Up" = "resize shrink height 2";
          "${mod}+Down" = "resize grow height 2";
          "${mod}+space" = "floating toggle";
          "${mod}+p" =
            "exec zathura ~/\"$(fd --no-ignore --base-directory ~ --type file --extension \".pdf\" | fuzzel -d --width 180 --prompt=\"󰈦 \")\"";
          "${mod}+x" =
            "exec xournalpp ~/\"$(fd --base-directory ~ --type file --extension \".xopp\" | fuzzel -d --width 180)\"";
          "${mod}+Shift+x" =
            "exec pdf=$(fd --base-directory ~ --type file --extension \".pdf\" | fuzzel -d --width 180 --prompt=\"󰈦 \") && dir=$(fd --base-directory ~ --type dir | fuzzel -d --width 180) && name=$(fuzzel -d -p \"New name: \" --lines 0) && cp ~/\"$pdf\" ~/\"$dir\"/\"$name\".pdf && xournalpp ~/\"$dir\"/\"$name\".pdf";
          "${mod}+v" =
            "exec cliphist list | fuzzel -d --lines 20 --width 120 --prompt=\"󰅍 \" --with-nth 2 | cliphist decode | wl-copy";
          "${mod}+Shift+v" = "exec cliphist wipe";
          "${mod}+Shift+s" = "exec grim -g \"$(slurp)\" - | wl-copy";
          "${mod}+b" = "border toggle pixel normal";
          "${mod}+period" = "exec rofimoji --selector fuzzel --selector-args=\"--width 120\"";
          "${mod}+comma" =
            "exec rofimoji --files nerd_font.csv --selector fuzzel --selector-args=\"--width 120\"";

          "XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-";
          "XF86AudioRaiseVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+";
          "XF86AudioMute" = "exec wpctl set-mute   @DEFAULT_AUDIO_SINK@ toggle";
          "XF86AudioMicMute" = "exec wpctl set-mute   @DEFAULT_AUDIO_SOURCE@ toggle";
          "XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
          "XF86MonBrightnessUp" = "exec brightnessctl set 5%+";
          "XF86AudioPlay" = "exec playerctl play-pause";
          "XF86PickupPhone" = "exec playerctl play-pause";
          "XF86Display" = "exec wl-present mirror";
        };
      };

      extraConfigEarly = ''
        # give sway a little time to startup before starting kanshi.
        exec_always sleep 2; systemctl --user start kanshi.service
        exec_always ${pkgs.seahorse}bin/gnome-keyring-daemon --start --daemonize --components=ssh,secrets,pkcs11
        exec_always swaybg -i ~/nix/stylix/background.jpg -m fill
        exec dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
      '';

      extraConfig = ''
        input * repeat_delay 200
        input * repeat_rate 40
        input 1133:50503:Logitech_USB_Receiver accel_profile flat
        input * accel_profile adaptive
        input type:touchpad natural_scroll enable
        focus_follows_mouse no
        default_border pixel
        bindgesture swipe:3:left focus left
        bindgesture swipe:3:right focus right
        bindgesture swipe:3:down focus down
        bindgesture swipe:3:up focus up
      '';
    };
  services.swayidle = {
    enable = true;
    timeouts = [
      {
        timeout = 180;
        command = "${pkgs.hyprlock}/bin/hyprlock";
      }
      {
        timeout = 185;
        command = "${pkgs.sway}/bin/swaymsg 'output * dpms off'";
        resumeCommand = "${pkgs.sway}/bin/swaymsg 'output * dpms on'";
      }
    ];
    events = [
      {
        event = "before-sleep";
        command = "${pkgs.hyprlock}/bin/hyprlock";
      }
    ];
  };
}
