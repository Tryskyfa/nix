{
  xdg = {
    portal = {
      enable = true;
      wlr = {
        enable = true;
        # settings = {
        #   screencast = {
        #     chooser_type = "dmenu";
        #     chooser_cmd = "fuzzel -d";
        #     max_fps = 60;
        #   };
        # };
      };
      config = {
        common = {
          "org.freedesktop.impl.portal.Secret" = [
            "gnome-keyring"
          ];
          "org.freedesktop.impl.portal.Screenshot" = "wlr";
          "org.freedesktop.impl.portal.ScreenCast" = "wlr";
        };
      };
    };
  };

}
