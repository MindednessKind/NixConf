{ self, inputs, ... }: {
  flake.nixosModules.bottles = { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        cacert
        (pkgs.bottles.override { removeWarningPopup = true; })
      ];
    };
}
