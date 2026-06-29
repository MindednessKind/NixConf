{ self, inputs, pkgs, ... }: {

  flake.nixosModules.myMachineConfiguration = { config, pkgs, ... }: {
    imports =
      [

        self.nixosModules.inputMethod
        self.nixosModules.myMachineHardware
        self.nixosModules.myFonts
        self.nixosModules.niri

        self.nixosModules.alacritty
        self.nixosModules.yazi

      ];
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "nixos"; # Define your hostname.
    networking.wireless.enable = true;
    # Enable networking
    networking.networkmanager.enable = true;

    # Set your time zone.
    time.timeZone = "Asia/Shanghai";

    # Select internationalisation properties.
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

    # Enable the GDM Environment.
    services.displayManager.gdm.enable = true;

    # Enable Bluetooth
    hardware.bluetooth.enable = true;

    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "cn";
      variant = "";
    };

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


    # Enable CUPS to print documents.
    services.printing.enable = true;

    # Enable sound with pipewire.
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };

    # Enable touchpad support (enabled default in most desktopManager).
    services.libinput.enable = true;

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.mind = {
      isNormalUser = true;
      description = "M1ndedness";
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [
        thunderbird
      ];
    };

    # Install firefox.
    programs.firefox.enable = true;

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
      vim
      git
      wget
      thunar
      pciutils
      mesa-demos
      fastfetch

      wl-clipboard

      inputs.nixvim.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    environment.variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    programs.git.enable = true;
    programs.git.config.core.editor = "nvim";

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    # List services that you want to enable:

    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "26.11"; # Did you read the comment?
  };
}
