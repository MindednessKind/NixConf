{ self, inputs, ... }: {

  flake.nixosModules.niri = { pkgs, lib, ... }: {

    services.xserver.enable = true;
    programs.niri = {

      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;

    };

  };

  perSystem = { pkgs, lib, ... }: {
    packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;
      config."config.kdl".content = /* kdl */ ''
        window-rule {
          match app-id="dev.noctalia.Noctalia.Settings"
          open-floating true
          default-column-width { fixed 1080; }
          default-window-height { fixed 920; }

          clip-to-geometry true
          geometry-corner-radius 20
        }

        layer-rule {
          match namespace="^noctalia-backdrop"
          place-within-backdrop true
        }
      '';

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

        shell.niri_overview_type_to_launch_enabled = true;

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


          "Alt+Space".spawn-sh = "${
            lib.getExe self.packages.${pkgs.stdenv.hostPlatform.system}.myNoctalia
          } msg panel-toggle launcher";

          "Mod+S".spawn-sh = "${
            lib.getExe self.packages.${pkgs.stdenv.hostPlatform.system}.myNoctalia
          } msg panel-toggle control-center";

          "Mod+Comma".spawn-sh = "${
            lib.getExe self.packages.${pkgs.stdenv.hostPlatform.system}.myNoctalia
          } msg settings-toggle";

          "XF86AudioRaiseVolume".spawn-sh = "${
            lib.getExe self.packages.${pkgs.stdenv.hostPlatform.system}.myNoctalia
          } msg volumn-up";

          "XF86AudioLowerVolume".spawn-sh = "${
            lib.getExe self.packages.${pkgs.stdenv.hostPlatform.system}.myNoctalia
          } msg volumn-down";

          "XF86AudioMute".spawn-sh = "${
            lib.getExe self.packages.${pkgs.stdenv.hostPlatform.system}.myNoctalia
          } msg volumn-mute";

          "XF86MonBrightnessUp".spawn-sh = "${
            lib.getExe self.packages.${pkgs.stdenv.hostPlatform.system}.myNoctalia
          } msg brightness-up";

          "XF86MonBrightnessDown".spawn-sh = "${
            lib.getExe self.packages.${pkgs.stdenv.hostPlatform.system}.myNoctalia
          } msg brightness-down";

          "Alt+F4".spawn-sh = "${
            lib.getExe self.packages.${pkgs.stdenv.hostPlatform.system}.myNoctalia
          } msg panel-toggle session";


          "Mod+Return".spawn-sh = "alacritty";

          "Mod+Q".close-window = { };

        };

      };

    };

  };
}
