{ self, inputs, ... }:
{
  # 使用 flake-parts 的 wrappers 系统
  flake.wrappers.yazi = { pkgs, wlib, lib, ... }:
    {
      # 导入 wrapper-modules 自带的 yazi 模块
      imports = [ wlib.wrapperModules.yazi ];

      # ========== 基本配置 ==========
      # 指定要包装的包
      package = pkgs.yazi;

      # ========== 运行时依赖 ==========
      # Yazi 需要的额外运行时包
      runtimePkgs = with pkgs; [
        # 文件预览依赖
        chafa # 图片预览
        ffmpegthumbnailer # 视频预览
        poppler # PDF 预览
        bat # 语法高亮
        eza # 更好的 ls
        fd # 文件查找
        ripgrep # 内容搜索
        unzip # 解压支持
        p7zip # 7z 支持
        # 可选：更多预览工具
        imagemagick # 图片处理
        ueberzugpp # 图片预览（终端）
        jq # JSON 处理
        yq # YAML 处理
      ];

      # ========== 环境变量 ==========
      env = {
        # Yazi 配置目录（可以指向您的自定义配置）
        # YAZI_CONFIG_DIR = "${config.constructFiles.configDir}/yazi";

        # 设置编辑器
        EDITOR = "${pkgs.neovim}/bin/nvim";

        # 设置文件管理器
        FILE = "${pkgs.yazi}/bin/yazi";

        # 语言设置
        LANG = "en_US.UTF-8";
        LC_ALL = "en_US.UTF-8";
      };

      # ========== 脚本包装 ==========
      # 在运行主程序前执行的 shell 脚本
      runShell = [
        # 创建必要的目录
        ''
          mkdir -p "$HOME/.config/yazi"
          mkdir -p "$HOME/.local/share/yazi"
        ''

        # 可以在这里添加其他初始化脚本
        # ''
        #   echo "Starting Yazi with custom wrapper..."
        # ''
      ];

      # ========== 构建文件（配置） ==========
      # 使用 constructFiles 创建配置文件
      constructFiles = {
        # Yazi 主配置文件
        "yazi.toml".content = ''
          [opener]
          text = [
            { run = '${pkgs.neovim}/bin/nvim "$@"', block = true }
          ]
        
          [manager]
          # 显示隐藏文件
          show_hidden = true
          # 自动隐藏文件
          auto_hide = true
          # 排序方式
          sort_by = "modified"
          sort_reverse = true
          # 文件预览
          preview = true
          # 图片预览
          image_preview = true
        
          [preview]
          # 预览包装器
          wrap = true
          # 最大预览大小
          max_width = 600
          max_height = 400
          # Tab 大小
          tab_size = 4
        
          [filetype]
          # 文件类型规则
          rules = [
            # 图片文件
            { name = "*.{png,jpg,jpeg,gif,bmp,svg,webp}", mime = "image/*" }
            # 视频文件
            { name = "*.{mp4,avi,mkv,mov,wmv,flv,webm}", mime = "video/*" }
            # 音频文件
            { name = "*.{mp3,flac,wav,ogg,m4a,aac}", mime = "audio/*" }
            # 文档文件
            { name = "*.{pdf,doc,docx,xls,xlsx,ppt,pptx}", mime = "application/*" }
            # 压缩文件
            { name = "*.{zip,rar,7z,tar,gz,bz2,xz}", mime = "application/*" }
            # 代码文件
            { name = "*.{rs,go,py,js,ts,html,css,json,yml,yaml,toml,xml}", mime = "text/*" }
          ]
        
          [theme]
          # 颜色主题
          # 使用内置主题或自定义
          flavor = "catppuccin-mocha"
        '';

        # Yazi 键位绑定配置
        "keymap.toml".content = ''
          # Yazi 键位绑定
          # 参考: https://yazi-rs.github.io/docs/keymap
        
          [[manager.prepend_keymap]]
          on = [ "h" ]
          run = "cd -- .."
          desc = "Go back"
        
          [[manager.prepend_keymap]]
          on = [ "l" ]
          run = "open --"
          desc = "Open file"
        
          [[manager.prepend_keymap]]
          on = [ "H" ]
          run = "cd -- /"
          desc = "Go to root"
        
          [[manager.prepend_keymap]]
          on = [ "L" ]
          run = "cd -- ~"
          desc = "Go to home"
        
          [[manager.prepend_keymap]]
          on = [ "g", "g" ]
          run = "cd -- ~"
          desc = "Go to home"
        
          [[manager.prepend_keymap]]
          on = [ "g", "r" ]
          run = "cd -- /"
          desc = "Go to root"
        
          [[manager.prepend_keymap]]
          on = [ "f" ]
          run = "find --"
          desc = "Find files"
        
          [[manager.prepend_keymap]]
          on = [ "/" ]
          run = "find --"
          desc = "Find files"
        
          [[manager.prepend_keymap]]
          on = [ "space" ]
          run = "toggle --"
          desc = "Toggle selection"
        
          [[manager.prepend_keymap]]
          on = [ "y" ]
          run = "yank --"
          desc = "Yank file path"
        
          [[manager.prepend_keymap]]
          on = [ "p" ]
          run = "paste --"
          desc = "Paste file"
        
          [[manager.prepend_keymap]]
          on = [ "d" ]
          run = "remove --"
          desc = "Delete file"
        
          [[manager.prepend_keymap]]
          on = [ "r" ]
          run = "rename --"
          desc = "Rename file"
        
          [[manager.prepend_keymap]]
          on = [ "e" ]
          run = "edit --"
          desc = "Edit file"
        
          [[manager.prepend_keymap]]
          on = [ "q" ]
          run = "close --"
          desc = "Close Yazi"
        
          [[manager.prepend_keymap]]
          on = [ "?" ]
          run = "help --"
          desc = "Show help"
        '';

        # Yazi 主题配置文件
        "flavors/catppuccin-mocha.toml".content = ''
          # Catppuccin Mocha 主题
          # 参考: https://github.com/catppuccin/yazi
        
          [flavor]
          name = "catppuccin-mocha"
          dark = true
          author = "Catppuccin"
        
          [flavor.bg]
          primary = "#1e1e2e"
          secondary = "#313244"
          tertiary = "#45475a"
        
          [flavor.fg]
          primary = "#cdd6f4"
          secondary = "#bac2de"
          tertiary = "#a6adc8"
        
          [flavor.status]
          mode_normal = { bg = "#1e1e2e", fg = "#cdd6f4" }
          mode_select = { bg = "#45475a", fg = "#f5e0dc" }
          mode_unset = { bg = "#1e1e2e", fg = "#cdd6f4" }
        
          [flavor.syntax]
          keyword = "#cba6f7"
          string = "#a6e3a1"
          number = "#fab387"
          comment = "#6c7086"
          function = "#89b4fa"
          variable = "#cdd6f4"
          constant = "#f9e2af"
          type = "#94e2d5"
          operator = "#89b4fa"
        '';
      };

      # ========== 包装标志 ==========
      # 传递给 makeWrapper 的参数
      flags = {
        # 可以添加命令行参数
        # "--config" = "${config.constructFiles.configDir}/yazi";
      };

      # ========== 额外包装器变体 ==========
      # 可以创建多个不同的包装版本
      # wrapperVariants = {
      #   # 例如创建一个带有调试输出的版本
      #   debug = {
      #     enable = true;
      #     runShell = [
      #       ''
      #         echo "Debug mode enabled"
      #         set -x
      #       ''
      #     ];
      #   };
      # };
    };

  # ========== NixOS 集成 ==========
  # 将包装好的 yazi 安装到系统
  flake.nixosModules.yazi = { pkgs, ... }:
    {
      # 使用 self.wrappers.yazi 或通过 flake-parts 自动生成的包
      environment.systemPackages = [
        # 如果使用 flake-parts，可以通过 self.packages.${system}.yazi 访问
        # 或者直接使用 inputs.wrapper-modules.wrappers.yazi.wrap
        (inputs.wrapper-modules.wrappers.yazi.wrap {
          inherit pkgs;
          # 可以在这里覆盖配置
        })
      ];

      # 设置环境变量
      environment.sessionVariables = {
        # 让 Yazi 使用我们的配置
        YAZI_CONFIG_DIR = "${pkgs.yazi}/etc/yazi";
      };
    };
}
