{ config, pkgs, lib, ... }:
{
  programs.git = {
    enable = true;
    userName = "Gleb Dovzhenko";
    userEmail = "dovjenko.g@gmail.com";
  };
}
