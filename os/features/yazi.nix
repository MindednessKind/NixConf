{ self, inputs, ... }: {
  flake.nixosModules.yazi = { pkgs, lib, ... }: {
    programs.yazi = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myYazi;
    };


  };

  perSystem = { pkgs, lib, ... }: {
    packages.myYazi = inputs.wrapper-modules.wrappers.yazi.wrap {

      inherit pkgs;

      plugins = with pkgs.yaziPlugins; {
        smart-enter = smart-enter;
        git = git;
        starship = starship;
        full-border = full-border;
      };
    };
  };
}
