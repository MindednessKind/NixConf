{ self, inputs, lib, ... }: {
  flake.nixosModules.nvim = { config, pkgs, ... }: {
    environment.systemPackages = [ inputs.nixvim.packages.${pkgs.stdenv.hostPlatform.system}.default ];

    environment.variables = lib.mkForce {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    programs.git.enable = true;
    programs.git.config.core.exitor = "nvim";

  };
}
