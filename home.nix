{ config, pkgs, ... }:

{
  home.username = "dichter";
  home.homeDirectory = "/home/dichter";
  home.stateVersion = "26.11";

  home.packages = with pkgs; [
    neovim
    fuzzel
    niri
    kitty
    fish
    starship
    zellij
  ];

  xdg.configFile = {
    "nvim".source = ./nvim;
    "fuzzel".source = ./fuzzel;
    "niri".source = ./niri;
    "kitty".source = ./kitty;
    "fish".source = ./fish;
    "zellij".source = ./zellij;
    "starship.toml".source = ./starship/starship.toml;
  };

  xdg.dataFile = {
    "applications/wl-mirror.desktop".source = ./applications/wl-mirror.desktop;
    "applications/fix-mouse.desktop".source = ./applications/fix-mouse.desktop;
  };
}
