{ self, inputs, ... }: {

  flake.nixosModules.niri = { pkgs, lib, ... }: {

    services.xserver.enable = true;
    programs.niri = {

      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;

    };

    environment.systemPackages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.myNoctalia
    ];

  };

  perSystem = { pkgs, lib, ... }: {
    packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;


      settings = {
        spawn-at-startup = [
          (lib.getExe self.packages.${pkgs.stdenv.hostPlatform.system}.myNoctalia)
        ];

        input.keyboard.xkb.layout = "us,ua";

        # Display Monitor Settings
        outputs = {
          "DP-6" = {
            position = _: {
              props = {
                x = 0;
                y = 0;
              };
            };
          };
          "HDMI-A-1" = {
            position = _: {
              props = {
                x = 2560;
                y = 0;
              };
            };
          };
          "eDP-2" = {
            position = _: {
              props = {
                x = 5120;
                y = 0;
              };
            };
          };
        };

        layout = {
          gaps = 5;

          focus-ring.off = _: { };

        };


        debug = {
          honor-xdg-activation-with-invalid-serial = _: { };
        };

        # niri_overview_type_to_launch_enabled = true;

        window-rules = [

          {
            geometry-corner-radius = 20;
            clip-to-geometry = true;
          }

          {
            matches = [
              {
                app-id = "dev.noctalia.Noctalia.Settings";
              }
            ];

            open-floating = true;

            default-column-width = {
              fixed = 1080;
            };

            default-window-height = {
              fixed = 920;
            };
          }

        ];

        binds = {

          "Ctrl+Shift+1".move-column-to-workspace = 1;
          "Ctrl+Shift+2".move-column-to-workspace = 2;
          "Ctrl+Shift+3".move-column-to-workspace = 3;
          "Ctrl+Shift+4".move-column-to-workspace = 4;

          "Mod+Shift+Slash".show-hotkey-overlay = _: { };



          "Mod+Prior".focus-workspace-up = _: { };
          "Mod+Shift+Prior".move-column-to-workspace = "+1";
          "Mod+Next".focus-workspace-down = _: { };
          "Mod+Shift+Next".move-column-to-workspace = "-1";


          "Mod+Left".focus-column-or-monitor-left = _: { };
          "Mod+Right".focus-column-or-monitor-right = _: { };

          "Mod+Shift+Left".move-column-to-monitor-left = _: { };
          "Mod+Shift+Right".move-column-to-monitor-right = _: { };

          "Mod+Ctrl+Left".move-column-left = _: { };
          "Mod+Ctrl+Right".move-column-right = _: { };

          "Mod+Backspace".maximize-column = _: { };
          "Mod+Backslash".switch-preset-column-width = _: { };

          "Mod+Ctrl+H".consume-or-expel-window-left = _: { };
          "Mod+Ctrl+L".consume-or-expel-window-right = _: { };

          "Mod+Tab".open-overview = _: { };


          "Alt+Space".spawn-sh = "noctalia-shell ipc call launcher toggle";

          "Mod+S".spawn-sh = "noctalia-shell ipc call control-center toggle";

          "Mod+Comma".spawn-sh = "noctalia-shell ipc call settings toggle";

          "XF86AudioRaiseVolume".spawn-sh = "noctalia-shell ipc call volume up";

          "XF86AudioLowerVolume".spawn-sh = "noctalia-shell ipc call volume down";

          "XF86AudioMute".spawn-sh = "noctalia-shell ipc call volume mute";

          "XF86MonBrightnessUp".spawn-sh = "noctalia-shell ipc call brightness up";

          "XF86MonBrightnessDown".spawn-sh = "noctalia-shell ipc call brightness down";

          "Alt+F4".spawn-sh = "noctalia-shell ipc call session toggle";

          "Mod+Return".spawn-sh = "alacritty";

          "Mod+Q".close-window = { };

        };

      };

    };

  };
}
