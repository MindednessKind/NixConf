{ self, inputs, ...}: {
  
  flake.nixosConfigurations.Mind = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.myMachineConfiguration
    ];
  };

}
