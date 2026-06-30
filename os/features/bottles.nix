{ self, inputs, ... }: {
  flake.nixosModules.wine = { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        bottles
      ];
    };
}
