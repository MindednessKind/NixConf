{ self, inputs, ... }: {
  flake.nixosModules.myFonts = { config, pkgs, ... }: {
    # 1. 安装字体
    fonts.packages = with pkgs; [
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      cascadia-code    

      # (b) 安装中文字体，Noto Fonts CJK 是很好的选择[citation:1][citation:11]
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      # 文泉驿字体也是一个轻量的备选方案[citation:11]
      # wqy_zenhei
    ];

    # 2. 配置默认字体
    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        # 设置等宽字体 (Monospace)，如终端使用。列表越靠前优先级越高[citation:8][citation:11]
        monospace = [
          "Cascadia Mono NF"
          "JetBrainsMono Nerd Font" # 此名称为字体在系统中的真实名称[citation:2][citation:3]
          "Noto Sans Mono CJK SC"
          "WenQuanYi Zen Hei Mono"
        ];
        # 设置无衬线字体 (Sans-serif)，用于界面
        sansSerif = [
          "Noto Sans CJK SC"
          "WenQuanYi Zen Hei"
        ];
        # 设置衬线字体 (Serif)，用于文档
        serif = [
          "Noto Serif CJK SC"
        ];
      };
    };
  };
}
