{ config, pkgs, lib, ... }:
{
  programs.zsh = {
    dotDir = ".config/zsh";
    enableCompletion = true;
    syntaxHighlighting = {
      enable = true;
    };
    initExtra = ''
    eval "$(direnv hook zsh)"
    '';
  };
}
