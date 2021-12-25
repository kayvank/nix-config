{ config, lib, pkgs, ... }:

let
  zshConfig = ''
    bindkey -v
    eval "$(direnv hook zsh)"
    # neofetch
    '';
in
{
  programs.zsh = {
    shellAliases = {
      # cat     = "bat";
      config    = "git --git-dir=$HOME/.cfg/ --work-tree=$HOME";
      dc        = "docker-compose";
      dps       = "docker-compose ps";
      dcd       = "docker-compose down --remove-orphans";
      emc       = "nohup emacsclient -c &> /dev/null &";
      emd       = "emacs --daemon";
      ping      = "prettyping";
      pbcopy    = "xclip -in -selection clipboard";
      pbpaste   = "xsel --clipboard";
      whaskell  = "cd ~/dev/workspaces/workspace-haskell";
      wsoos     = "cd ~/dev/workspaces/workspace-soostone";
      wproto    = "cd ~/dev/workspaces/workspace-proto";
      wnixos    = "cd ~/dev/workspaces/workspace-nixos";
      tmx       = "tmux new-session -s $USER-`date +%s`";
    };
    sessionVariables = { ## shell env vars are set here
      DIRENV_ALLOW_NIX=1;
      XX_FAKE_ENV = "fake-env-var";
       # CPATH=~/.include;
       # LIBRARY_PATH=~/.nix-profile/lib;
    };
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
    };

    initExtra   = zshConfig;
  };
}
