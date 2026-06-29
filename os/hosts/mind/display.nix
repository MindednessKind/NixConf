{ self, inputs, pkgs, ... }: {

  flake.nixosModules.myDisplayConfiguration = { config, pkgs, ... }: {
    # -- 地区/语言设置 ---

    i18n.defaultLocale = "zh_CN.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "zh_CN.UTF-8";
      LC_IDENTIFICATION = "zh_CN.UTF-8";
      LC_MEASUREMENT = "zh_CN.UTF-8";
      LC_MONETARY = "zh_CN.UTF-8";
      LC_NAME = "zh_CN.UTF-8";
      LC_NUMERIC = "zh_CN.UTF-8";
      LC_PAPER = "zh_CN.UTF-8";
      LC_TELEPHONE = "zh_CN.UTF-8";
      LC_TIME = "zh_CN.UTF-8";
    };

    # Set your time zone.
    time.timeZone = "Asia/Shanghai";

    # --- E N D ---



    # --- 显示驱动设置 ---
    services.displayManager.defaultSession = "niri";

    hardware.graphics.enable = true;
    hardware.nvidia.open = true;
    services.xserver.videoDrivers = [ "nvidia" ];
    nixpkgs.config.allowUnfree = true;

    hardware.nvidia.prime = {
      # 集成显卡（AMD）的 Bus ID
      intelBusId = "PCI:6:0:0";
      # 独立显卡（NVIDIA）的 Bus ID
      nvidiaBusId = "PCI:1:0:0";

      # 同步模式（sync）：NVIDIA 渲染后通过集成显卡输出，适合笔记本内屏
      # 如果你希望完全用 NVIDIA 作为主显卡，可以改为 "offload" 模式，
      # 但 sync 对大多数笔记本更稳定。这里选择 sync（默认）。
      # 如果不设置，默认就是 sync。
      # 也可以显式指定：
      sync.enable = true; # 这是默认行为
    };

    # 一些额外的内核参数，有助于提高 Wayland 下 NVIDIA 的稳定性
    boot.kernelParams = [ "nvidia_drm.modeset=1" ];
    # 启用 NVIDIA 持久化模式，提升性能
    hardware.nvidia.powerManagement.enable = true;

    # --- E N D ---




  };

}
