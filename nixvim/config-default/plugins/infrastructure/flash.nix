{ lib, ... }:

{
  plugins.flash = {
    enable = true;
  };

  keymaps = [
    {
      mode = [ "n" "x" "o" ];
      key = "s";
      action = lib.nixvim.mkRaw ''
        function()
          require("flash").jump()
        end
      '';
      options = {
        desc = "Flash";
      };
    }
    {
      mode = [ "n" "x" "o" ];
      key = "S";
      action = lib.nixvim.mkRaw ''
        function()
          require("flash").treesitter()
        end
      '';
      options = {
        desc = "Flash Treesitter";
      };
    }
    {
      mode = [ "o" ];
      key = "r";
      action = lib.nixvim.mkRaw ''
        function()
          require("flash").remote()
        end
      '';
      options = {
        desc = "Remote Flash";
      };
    }
    {
      mode = [ "x" "o" ];
      key = "R";
      action = lib.nixvim.mkRaw ''
        function()
          require("flash").treesitter_search()
        end
      '';
      options = {
        desc = "Treesitter Search";
      };
    }
    {
      mode = [ "c" ];
      key = "<c-s>";
      action = lib.nixvim.mkRaw ''
        function()
          require("flash").toggle()
        end
      '';
      options = {
        desc = "Toggle Flash Search";
      };
    }
  ];
}
