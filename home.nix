{ config, pkgs, lib, ... }:

{
  home.username = "glebd";
  home.homeDirectory = "/home/glebd";
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.git = {
    enable = true;
    userName = "Gleb Dovzhenko";
    userEmail = "dovjenko.g@gmail.com";
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  imports = [ ./programs ];
}

