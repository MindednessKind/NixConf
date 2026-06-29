{ self, inputs, ... }: {
  flake.nixosModules.inputMethod = { config, pkgs, ... }:
    let
      myFcitx5Rime = pkgs.fcitx5-rime.override {
        rimeDataPkgs = with pkgs; [
          rime-data
          rime-wanxiang
        ];
      };

      # 创建一个独立的主题包（类似 catppuccin-fcitx5）
      myFcitx5Themes = pkgs.stdenv.mkDerivation {
        name = "my-fcitx5-themes";
        src = ./inputTheme;

        installPhase = ''
          mkdir -p $out/share/fcitx5/themes
          
          # 复制所有主题
          cp -r bamboo-dark $out/share/fcitx5/themes/
          cp -r bamboo-light $out/share/fcitx5/themes/
          cp -r macOS-dark $out/share/fcitx5/themes/
          cp -r macOS-light $out/share/fcitx5/themes/
          cp -r wechat-dark $out/share/fcitx5/themes/
          cp -r wechat-light $out/share/fcitx5/themes/
        '';
      };
    in
    {
      # 关键：将主题包作为 fcitx5 的 addon 添加
      i18n.inputMethod = {
        enable = true;
        type = "fcitx5";
        fcitx5.addons = with pkgs; [
          myFcitx5Rime
          qt6Packages.fcitx5-configtool
          fcitx5-gtk

          myFcitx5Themes # 添加你的主题包
        ];
      };

      environment.variables = {
        XMODIFIERS = "@im=fcitx";
        GTK_IM_MODULE = "";
        QT_IM_MODULE = "";
        QT_IM_MODULES = "";
        MOZ_ENABLE_WAYLAND = 1;

      };

    };
}
