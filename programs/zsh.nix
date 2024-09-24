{ config, pkgs, lib, ... }:
{
  programs.zsh = {
    enableCompletion = true;
    syntaxHighlighting = {
      enable = true;
    };
    initExtra = ''
    eval "$(direnv hook zsh)"
    '';
  };
}
