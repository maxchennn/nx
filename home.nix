{ config, pkgs, ... }:

{
  home.username = "max";
  home.homeDirectory = "/home/max";
  home.stateVersion = "26.05";

  programs.git = {
    enable = true;
    userName = "maxchennn";
  };

  programs.starship.enable = true;
  programs.zoxide.enable = true;

  programs.home-manager.enable = true;
}
