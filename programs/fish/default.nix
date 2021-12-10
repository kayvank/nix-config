{ config, pkgs, lib, ... }:

let
  fzfConfig = ''
    set -x FZF_DEFAULT_OPTS "--preview='bat {} --color=always'" \n
    set -x SKIM_DEFAULT_COMMAND "rg --files || fd || find ."
  '';

  themeConfig = ''
    set -g theme_display_date no
    set -g theme_display_git_master_branch no
    set -g theme_nerd_fonts yes
    set -g theme_newline_cursor yes
    set -g theme_color_scheme solarized
  '';

  gpgConfig = ''
    set -gx GPG_TTY (tty)
   '';

  customPlugins = pkgs.callPackage ./plugins.nix {};

  fenv = {
    name = "foreign-env";
    src = pkgs.fishPlugins.foreign-env.src;
  };

  fishConfig = ''
    bind \t accept-autosuggestion
    set fish_greeting
    fish_vi_key_bindings
  '' + fzfConfig + themeConfig + gpgConfig;
in
{
  programs.fish = {
    enable = true;
    plugins = [ customPlugins.theme fenv ];
    promptInit = ''
      eval (direnv hook fish)
      any-nix-shell fish --info-right | source
      neofetch
    '';
    shellAliases = {
      cat       = "bat";
      d         = "dirh";
      dc        = "docker-compose";
      dcd       = "docker-compose down --remove-orphans";
      dps       = "docker-compose ps";
      du        = "ncdu --color dark -rr -x";
      emc       = "nohup emacsclient -c &> /dev/null &";
      emd       = "emacs --daemon";
      mfix      = "mill mono.__.fix --rules OrganizeImports && mill mono._.reformat";
      ls        = "exa";
      ll        = "ls -l";
      lla       = "ls -la";
      ".."      = "cd ..";
      pbcopy    = "xclip -in -selection clipboard";
      pbpaste   = "xsel --clipboard";
      ping      = "prettyping";
      whaskell  = "cd ~/dev/workspaces/workspace-haskell";
      wproto    = "cd ~/dev/workspaces/workspace-proto";
      wnixos    = "cd ~/dev/workspaces/workspace-nixos";
      tmx       = "tmux new-session -s $USER-`date +%s`";
      tma       = "tmux attach";
    };
    shellInit   = fishConfig;
  };

  xdg.configFile."fish/functions/fish_prompt.fish".text = customPlugins.prompt;
}
