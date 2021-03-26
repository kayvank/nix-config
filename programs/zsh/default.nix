{ config, lib, pkgs, ... }:

let
  myZConfig = ''
   bindkey -mv
    '';
in
{
  programs.zsh = {
    shellAliases = {
      config  = "git --git-dir=$HOME/.cfg/ --work-tree=$HOME";
      dc      = "docker-compose";
      dps     = "docker-compose ps";
      dcd     = "docker-compose down --remove-orphans";
      ping    = "prettyping";
    };
    oh-my-zsh = {
      enable = true;
      # theme = "robbyrussell";
    };
  };
}
