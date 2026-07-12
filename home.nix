{ config, pkgs, ... }:

let
  link = path: config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/${path}";
in
{
  home.username = "dichter";
  home.homeDirectory = "/home/dichter";
  home.stateVersion = "26.11";

  home.packages = with pkgs; [
    home-manager
    bash
    bat
    fish
    fuzzel
    kitty
    mpd
    mpv
    neovim
    niri
    starship
    zellij
    btop
  ];

  home.file = {
    ".bashrc".source = ./bash/.bashrc;
  };

  xdg.configFile = {
    "nvim".source = link "nvim";
    "fish".source = link "fish";
    "zellij".source = link "zellij";
    "kitty".source = link "kitty";

    "fuzzel".source = ./fuzzel;
    "niri".source = ./niri;
    "btop".source = ./btop;
    "bat".source = ./bat;
    "mpd".source = ./mpd;
    "mpv".source = ./mpv;
    "starship.toml".source = ./starship/starship.toml;
  };

  xdg.dataFile = {
    "applications/wl-mirror.desktop".source = ./applications/wl-mirror.desktop;
    "applications/fix-mouse.desktop".source = ./applications/fix-mouse.desktop;
  };
}
