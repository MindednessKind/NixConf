{ self, inputs, ... }: {
  flake.nixosModules.bottles = { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        bottles
      ];
    };
}
