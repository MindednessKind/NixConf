{ self, inputs, ... }: {
  flake.nixosModules.bottles = { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        (pkgs.bottles.override { removeWarningPopup = true; })
      ];
    };
}
