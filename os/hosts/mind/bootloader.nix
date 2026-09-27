{ self, inputs, ... }: {
  flake.nixosModules.bootLoader = { config, pkgs, ... }: {
    boot.loader.grub = {
      enable = true;
      device = "nodev"; # UEFI 系统
      efiSupport = true;
      useOSProber = true;

      default = "saved";
      extraEntries = "GRUB_SAVEDEFAULT=true";
    };


  };

}
