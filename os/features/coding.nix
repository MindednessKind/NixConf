{ self, inputs, ... }: {

  flake.nixosModules.coding = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      python313

      rustc
      catgo

      gcc
      clang
      gnumake
      cmake
    ];


  };

}
