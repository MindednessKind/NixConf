{ self, inputs, ... }:
{

  flake.nixosModules.chatApps = { pkgs, ... }: {
    environment.systemPackages = with pkgs; {
      qq
        wechat
        telegram-desktop

        };
        };
        }
