{ self, inputs, ... }:
{
  flake.nixosModules.chatApps = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      wechat-uos
      telegram-desktop
    ];
  };
}
