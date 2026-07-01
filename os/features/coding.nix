{ self, inputs, ... }: {

  flake.nixosModules.coding = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      python313

      rustc
      cargo

      gcc
      clang
      gnumake
      cmake

      pkg-config

      openssl
      sqlite

      wireshark
      bluez
      wireless-tools
      tcpdump
      usbutils
      iproute2
      ethtool
      lsof
      gawk
      coreutils
    ];


  };

}
