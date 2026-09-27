{ self, inputs, ... }: {
  flake.nixosModules.bootLoader = { config, pkgs, ... }: {
    boot.loader.grub = {
      enable = true;
      device = "nodev"; # UEFI 系统
      efiSupport = true;
      useOSProber = true; # 自动探测 Windows 启动项 [citation:1][citation:3]
    };
    boot.loader.efi.canTouchEfiVariables = true;
  };

}
