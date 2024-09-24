{ config, pkgs, lib, ... }:

{
  home.username = "glebd";
  home.homeDirectory = "/home/glebd"; 
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;

  imports = [./programs];
}

