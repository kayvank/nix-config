{ config, lib, pkgs, ... }:

let
  zshConfig = ''
    eval "$(direnv hook zsh)"
    neofetch
  '';
in {
  programs.zsh = {
    autocd = true;
    dotDir = ".config/zsh";
    enableCompletion = true;
    enableAutosuggestions = true;

    sessionVariables = {
      CPATH = "/home/soostone/.nix-profile/include";
      LIBRARY_PATH = "/home/soostone/.nix-profile/lib";

    };
    shellAliases = {
      config = "git --git-dir=$HOME/.cfg/ --work-tree=$HOME";
      dc = "docker-compose";
      dps = "docker-compose ps";
      dcd = "docker-compose down --remove-orphans";
      emc = "nohup emacsclient -c &> /dev/null &";
      emd = "emacs --daemon";
      egrep = "egrep --color=auto";
      fgrep = "fgrep --color=auto";
      grep = "grep --color=auto";
      k = "kubectl";
      sl = "exa";
      ls = "exa";
      ll = "exa -l";
      la = "exa -la";
      ip = "ip --color";
      pbcopy = "xclip -in -selection clipboard";
      pbpaste = "xsel --clipboard";
      ping = "prettyping";
      whaskell = "cd ~/dev/workspaces/workspace-haskell";
      wnixos = "cd ~/dev/workspaces/workspace-nixos";
      wproto = "cd ~/dev/workspaces/workspace-proto";
      wsoostone = "cd ~/dev/workspaces/workspace-soostone";
    };
    plugins = [{
      name = "zsh-nix-shell";
      file = "nix-shell.plugin.zsh";
      src = pkgs.fetchFromGitHub {
        owner = "chisui";
        repo = "zsh-nix-shell";
        rev = "v0.1.0";
        sha256 = "0snhch9hfy83d4amkyxx33izvkhbwmindy0zjjk28hih1a9l2jmx";
      };
    }];
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ "git" "sudo" "docker" "kubectl" "vi-mode" "gpg-agent" ];

    };
    initExtra = zshConfig;
  };
}
