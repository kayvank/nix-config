{ config, lib, pkgs, stdenv, ... }:

let
  defaultPkgs = with pkgs; [
    any-nix-shell        # fish support for nix shell
    arandr               # simple GUI for xrandr
    asciinema            # record the terminal
    audacious            # simple music player
    bitwarden-cli        # command-line client for the password manager
    bloop                # Scala build server
    bottom               # alternative to htop & ytop
    brave                # Browser
    cachix               # nix caching
    cinnamon.nemo        # filemanager
    chromium             # Browser
    clisp
    conky
    coreutils
    dmenu                # application launcher
    docker-compose       # docker manager
    dive                 # explore docker layers
    # element-desktop      # a feature-rich client for Matrix.org
    exa                  # a better `ls`
    feh                  # image viewer and cataloguer
    fd                   # "find" for files
    gcc
    gem
    # ghc
    gmrun
    gnumake
    gnome.dconf
    gimp                 # gnu image manipulation program
    git
    gnomecast            # chromecast local files
    htop
    hyperfine            # command-line benchmarking tool
    ispell
    insomnia             # rest client with graphql support
    jitsi-meet-electron  # open source video calls and chats
    k9s                  # k8s pods manager
    killall              # kill processes by name
    libnotify            # notify-send command
    lorri
 ###   multilockscreen      # fast lockscreen based on i3lock
    manix                # documentation searcher for nix
    mate.atril           # pdf reader
    metals               # scala build for emacs
    ncdu                 # disk space info (a better du)
    neofetch             # command-line system information
    ngrok-2              # secure tunneling to localhost
    nix-doc              # nix documentation search tool
    nixfmt
    nix-index            # files database for nixpkgs
    nyancat              # the famous rainbow cat!
#    oh-my-zsh            # zshell stuff
    pa_applet            # pulse audio applet
    pavucontrol          # pulseaudio volume control
    paprefs              # pulseaudio preferences
    pasystray            # pulseaudio systray
    playerctl            # music player controller
    polybar              # for xmonad
    postgresql
    prettyping           # a nicer ping
    python
    pulsemixer           # pulseaudio mixer
    racket
    ranger               # command line file browser
    ripgrep              # fast grep
    rnix-lsp             # nix lsp server
    # rofi                 # app luncher
    ruby
    sbcl
    sbt
    signal-desktop       # signal messaging client
    simplescreenrecorder # self-explanatory
    # slack                # messaging client
    sqlite
    sqlitebrowser
    spotify              # music source
    stalonetray
    trayer
    tdesktop             # telegram messaging client
    terminator           # great terminal multiplexer
    tldr                 # summary of a man page
    tree                 # display files in a tree view
    tmux
    unzip
    vim
    vlc                  # media player
    virt-manager
    watchman
    xclip                # clipboard support (also for vim)
    xmobar               # for xmonad
    xsel
    yad                  # yet another dialog - fork of zenity
    zlib
    # fixes the `ar` error required by cabal
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
    cabal2nix # convert cabal projects to nix
    cabal-install # package manager
    # structured-haskell-mode
    ghc
    ghcid
    # ghcup
    ghcid # compiler
    haskell-language-server
    dhall-lsp-server
    hoogle # documentation
    hlint
    hpack
    implicit-hie # hie
    hie-bios
    niv
    nix-tree # visualize nix dependencies
    ormolu
    # stack
    stylish-haskell
    termonad
 ];
 rustPkgs = with pkgs; [ rustup ];

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

# programs.emacs = {
#     enable = true;
#     extraPackages = epkgs: [
#       epkgs.nix-mode
#       epkgs.magit
#     ];
#   };


  programs.home-manager.enable = true;

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
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
    username      = "kayvan";
    homeDirectory = "/home/kayvan";
    stateVersion  = "22.05";

    packages =
      defaultPkgs ++
      gitPkgs ++
      gnomePkgs ++
      haskellPkgs ++
      polybarPkgs ++
      scripts ++
      xmonadPkgs
    ;

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
    };

    direnv = {
      enable = true;
      enableFishIntegration = true;
      nix-direnv.enable = true;
    };

    fzf = {
      enable = true;
      enableFishIntegration = true;
    };

    gpg.enable = true;

    # htop = {enable = true; sortDescending = true; sortKey = "PERCENT_CPU";};


    jq.enable = true;
#    ssh.enable = true;
  };


  services = {
    flameshot.enable = true;
  };

}
