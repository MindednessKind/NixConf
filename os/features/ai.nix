{ self, inputs, ... }: {

  flake.nixosModules.ai = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      codex
      claude-code
      opencode

    ];
  };
}
