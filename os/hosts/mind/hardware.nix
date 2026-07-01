{ self, inputs, ... }: {
  flake.nixosModules.myMachineHardware = { config, lib, pkgs, modulesPath, ... }: {
    imports =
      [
        (modulesPath + "/installer/scan/not-detected.nix")
      ];

    boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "usbhid" "usb_storage" "sd_mod" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-amd" ];
    boot.extraModulePackages = [ ];

    fileSystems."/" =
      {
        device = "/dev/disk/by-uuid/f5d431a5-cce1-4266-8d32-fb3522572f2a";
        fsType = "ext4";
      };

    fileSystems."/boot" =
      {
        device = "/dev/disk/by-uuid/AACE-C76C";
        fsType = "vfat";
        options = [ "fmask=0077" "dmask=0077" ];
      };

    fileSystems."/mnt/d" =
      {
        device = "/dev/disk/by-uuid/95D63408CFBE3AD8";
        fsType = "ntfs";
        options = [
          "defaults"
          "nofail" # 如果硬盘没插上，系统也能正常启动
          "uid=1000" # 用你的用户ID，让普通用户有读写权限
          "gid=100" # 用你的用户组ID
          "umask=022" # 权限掩码，让文件可读可写
        ];
      };

    fileSystems."/mnt/c" =
      {
        device = "/dev/disk/by-uuid/AC98E31F98E2E6B4";
        fsType = "ntfs";
        options = [
          "defaults"
          "nofail"
          "uid=1000"
          "gid=100"
          "umask=022"
        ];
      };


    swapDevices = [ ];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
