{ config, pkgs, lib, ... }:
{
  programs.zsh = {
    enableCompletion = true;
    syntaxHighlighting = {
      enable = true;
    };
  };
}
