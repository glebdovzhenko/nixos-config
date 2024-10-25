{ config, pkgs, lib, ... }:
{

  programs.alacritty = {
    enable = true;
    settings = {
      font.size = 18;
      font.normal.family = "DejaVuSansM Nerd Font";
      window.decorations = "none";
      keyboard.bindings = [
        {
          key = "Enter";
          mods = "Alt";
          action = "ToggleFullScreen";
        }
      ];

      # TokyoNight Alacritty Colors
      colors.primary.background = "#24283b";
      colors.primary.foreground = "#c0caf5";

      colors.cursor.cursor = "#c0caf5";
      colors.cursor.text = "#24283b";

      colors.normal.black = "#1d202f";
      colors.normal.red = "#f7768e";
      colors.normal.green = "#9ece6a";
      colors.normal.yellow = "#e0af68";
      colors.normal.blue = "#7aa2f7";
      colors.normal.magenta = "#bb9af7";
      colors.normal.cyan = "#7dcfff";
      colors.normal.white = "#a9b1d6";

      colors.bright.black = "#414868";
      colors.bright.red = "#f7768e";
      colors.bright.green = "#9ece6a";
      colors.bright.yellow = "#e0af68";
      colors.bright.blue = "#7aa2f7";
      colors.bright.magenta = "#bb9af7";
      colors.bright.cyan = "#7dcfff";
      colors.bright.white = "#c0caf5";

      colors.indexed_colors = [
        {
          index = 16;
          color = "#ff9e64";
        }
        {
          index = 17;
          color = "#db4b4b";
        }
      ];
    };
  };
}

