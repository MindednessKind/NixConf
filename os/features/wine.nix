{ self, inputs, ... }:
{
  flake.nixosModules.wine = { pkgs, ... }: {
    programs.nix-ld.enable = true;
    services.xembed-sni-proxy.enable = true;

    environment.systemPackages = with pkgs; [
      wineWow64Packages.stableFull
      winetricks
    ];
  };
}
