{ config, lib, pkgs, stdenv, ... }:

let
  defaultPkgs = with pkgs; [
    alacritty
    any-nix-shell        # fish support for nix shell
    arandr               # simple GUI for xrandr
    asciinema            # record the terminal
    audacious            # simple music player
    bitwarden-cli        # command-line client for the password manager
    bloop                # Scala build server
    blueman              # bluetooth manager
    bottom               # alternative to htop & ytop
    brave                # Browser
    cachix               # nix caching
    cinnamon.nemo        # filemanager
    chromium             # Browser
    dconf2nix            # dconf (gnome) files to nix converter
    dmenu                # application launcher
    docker-compose       # docker manager
    dive                 # explore docker layers
    element-desktop      # a feature-rich client for Matrix.org
    # emacs
    exa                  # a better `ls`
    fd                   # "find" for files
    feh
    gimp                 # gnu image manipulation program
    gnomecast            # chromecast local files
    haskellPackages.implicit-hie # hie
    hyperfine            # command-line benchmarking tool
    insomnia             # rest client with graphql support
    jitsi-meet-electron  # open source video calls and chat
    k9s                  # k8s pods manager
    killall              # kill processes by name
    konsole
    libreoffice          # office suite
    libnotify            # notify-send command

    ##multilockscreen      # fast lockscreen based on i3lock
    manix                # documentation searcher for nix
    mate.atril           # pdf reader
    metals               # scala build for emacs
    ncdu                 # disk space info (a better du)
    neofetch             # command-line system information
    ngrok-2              # secure tunneling to localhost
    nix-doc              # nix documentation search tool
    nix-index            # files database for nixpkgs
    nixos-icons
    nodejs               # npm and node
    nodePackages.node2nix # node to nix
    nyancat              # the famous rainbow cat!
    ormolu               # haskell formatter
    pulseaudio           # autio control
    pa_applet            # pulse audio applet
    pavucontrol          # pulseaudio volume control
    paprefs              # pulseaudio preferences
    pasystray            # pulseaudio systray
    playerctl            # music player controller
    polybar              # for xmonad
    prettyping           # a nicer ping
    pulsemixer           # pulseaudio mixer
    ranger               # command line file browser
    ripgrep              # fast grep
    rnix-lsp             # nix lsp server
    sbt                  # scala sbt
    sbcl                 # lisp compiler
    signal-desktop       # signal messaging client
    simplescreenrecorder # self-explanatory
    slack                # messaging client
    sqlite
    spotify              # music source
    stalonetray
    tdesktop             # telegram messaging client
    terminator           # great terminal multiplexer
    tldr                 # summary of a man page
    tree                 # display files in a tree view
    tmux
    vlc                  # media player
    vim
    watchman
    xclip                # clipboard support (also for vim)
    xfce.xfce4-pulseaudio-plugin
    xmobar               # for xmonad
    # xscreensaver         # lock screen
    xsel
    yad                  # yet another dialog - fork of zenity
    yarn
    yarn2nix
    # fixes the `ar` error required by cabal
    binutils-unwrapped
  ];

  gitPkgs = with pkgs.gitAndTools; [
    diff-so-fancy # git diff with colors
    git-crypt     # git files encryption
    hub           # github command-line client
    tig           # diff and commit view
  ];

  gnomePkgs = with pkgs.gnome3; [
    eog            # image viewer
    evince         # pdf reader
    gnome-calendar # calendar
    nautilus       # file manager
  ];

  haskellPkgs = with pkgs.haskellPackages; [
    brittany                # code formatter
    cabal2nix               # convert cabal projects to nix
    cabal-install           # package manager
    ghc                     # compiler
    haskell-language-server # haskell IDE (ships with ghcide)
    hoogle                  # documentation
    nix-tree                # visualize nix dependencies
    ormolu
    stylish-haskell
  ];

  polybarPkgs = with pkgs; [
    font-awesome-ttf      # awesome fonts
    material-design-icons # fonts with glyphs
  ];

  scripts = pkgs.callPackage ./scripts/default.nix { inherit config pkgs; };

  xmonadPkgs = with pkgs; [
    networkmanager_dmenu   # networkmanager on dmenu
    networkmanagerapplet   # networkmanager applet
    nitrogen               # wallpaper manager
    xcape                  # keymaps modifier
    xorg.xkbcomp           # keymaps modifier
    xorg.xmodmap           # keymaps modifier
    xorg.xrandr            # display manager (X Resize and Rotate protocol)
  ];

in
{
  programs.home-manager.enable = true;

  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = p: {
      nur = import (import pinned/nur.nix) { inherit pkgs; };
    };
  };

  nixpkgs.overlays = [
    (import ./overlays/beauty-line)
  ];

  imports = (import ./programs) ++ (import ./services) ++ [(import ./themes)];

  xdg.enable = true;

  home = {
    username      = "soostone";
    homeDirectory = "/home/soostone";
    stateVersion  = "21.03";

    packages = defaultPkgs ++ gitPkgs ++ gnomePkgs ++ haskellPkgs ++ polybarPkgs ++ scripts ++ xmonadPkgs;

    sessionVariables = {
      DISPLAY = ":0";
      EDITOR = "vim";
    };
  };

  # notifications about home-manager news
  news.display = "silent";

  programs = {
    bat.enable = true;

    broot = {
      enable = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
    };

    direnv = {
      enable = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      enableNixDirenvIntegration = true;
    };

    fzf = {
      enable = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
    };

    gpg.enable = true;

    htop = {
      enable = true;
      sortDescending = true;
      sortKey = "PERCENT_CPU";
    };

    zsh = {
      enable = true;
    };

    jq.enable = true;
    ssh.enable = true;

  };

  services = {
    flameshot.enable = true;
    # xscreensaver = {enable = true; settings = { lock = true; };};
  };

}
