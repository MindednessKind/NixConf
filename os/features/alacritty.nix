{ self, inputs, ... }:
{

  flake.nixosModules.alacritty = { pkgs, ... }:
    let
      wrappedAlacritty = inputs.wrapper-modules.wrappers.alacritty.wrap
        {
          inherit pkgs;
          settings = {
            font.normal = {
              family = "Cascadia Mono NF";
            };
            window.opacity = 0.9;
          };

        };
    in
    {
      # 直接把它添加到系统包中，或者通过其他方式使用
      environment.systemPackages = [ wrappedAlacritty ];
    };
}
