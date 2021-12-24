{ config, lib, pkgs, stdenv, ... }:
let
  defaultPkgs = with pkgs; [
    alacritty
    any-nix-shell # fish support for nix shell
    ansible
    arandr # simple GUI for xrandr
    nodePackages.js-yaml
    asciinema # record the terminal
    audacious # simple music player
    awscli
    bitwarden-cli # command-line client for the password manager
    black
    bloop # Scala build server
    blueman # bluetooth manager
    bottom # alternative to htop & ytop
    brave # Browser
    cachix # nix caching
    cinnamon.nemo # filemanaroe
    chromium # Browser
    cmake
    cowsay
    dconf2nix # dconf (gnome) files to nix converter
    direnv
    dmenu # application launcher
    docker-compose # docker manager
    dive # explore docker layers
    dos2unix
    opendune
    emacs
    exa
    editorconfig-core-c
    fd # "find" for files
    feh
    # firefox
    gcc
    google-cloud-sdk
    gmp
    glibc
    glib
    gtk3
    gnomecast # chromecast local files
    hyperfine # command-line benchmarking tool
    html-tidy
    interception-tools
    insomnia # rest client with graphql support
    iotop
    jitsi-meet-electron # open source video calls and chat
    k9s # k8s pods manager
    killall # kill processes by name
    konsole
    libnotify # notify-send command
    libtool # # required by emacs vterm
    libvterm # # required by emacs vterm
    lorri

    ##multilockscreen      # fast lockscreen based on i3lock
    manix # documentation searcher for nix
    markdown-pp
    mate.atril # pdf reader
    metals # scala build for emacs
    ncdu # disk space info (a better du)
    neofetch # command-line system information
    ngrok-2 # secure tunneling to localhost
    nix-doc # nix documentation search tool
    nix-index # files database for nixpkgs
    nix-prefetch
    nix-prefetch-git
    nixos-icons
    nodejs # npm and node
    nyancat # the famous rainbow cat!
    ocaml
    ocamlformat
    pulseaudio # autio control
    pa_applet # pulse audio applet
    pavucontrol # pulseaudio volume control
    paprefs # pulseaudio preferences
    pasystray # pulseaudio systray
    playerctl # music player controller
    polybar # for xmonad
    prettyping # a nicer ping
    postgresql
    pulsemixer # pulseaudio mixer
    pipenv
    ranger # command line file browser
    ripgrep # fast grep
    rnix-lsp # nix lsp server
    ruby

    sbt # scala sbt
    sbcl # lisp compiler
    shfmt
    signal-desktop # signal messaging client
    simplescreenrecorder # self-explanatory
    slack # messaging client
    sqlite
    spotify # music source
    stack
    stalonetray
    tdesktop # telegram messaging client
    terraform
    gnome.gnome-terminal
    terminator # great terminal multiplexer
    tldr # summary of a man page
    tree # display files in a tree view
    tmux

    vlc # media player
    vim
    vscode ## -extensions.haskell.haskell
    watchman
    whatsapp-for-linux
    xclip # clipboard support (also for vim)
    xcape
    xfce.xfce4-pulseaudio-plugin
    xmobar # for xmonad
    # xscreensaver         # lock screen
    xsel
    yad # yet another dialog - fork of zenity
    yarn
    yarn2nix
    zlib
    # fixes the `ar` error required by cabal
    # binutils-unwrapped
  ];

  gnomePkgs = with pkgs.gnome3; [
    eog # image viewer
    evince # pdf reader
    gnome-calendar # calendar
    nautilus # file manager
  ];

  pythonPkgs = with pkgs.python38Packages; [
    argcomplete
    pylint
    pip
    isort
    pytest
    pyflakes
  ];
  gitPkgs = with pkgs.gitAndTools; [
    diff-so-fancy # git diff with colors
    git-crypt # git files encryption
    hub # github command-line client
    tig # diff and commit view
    # purescript
    spago
  ];
  nodePkgs = with pkgs.nodePackages; [
    node2nix # node to nix
    prettier
    eslint
    purty
    yaml-language-server
    stylelint
    js-beautify
  ];
  haskellPkgs = with pkgs.haskellPackages; [
    apply-refact
    brittany # code formatter
    cabal2nix # convert cabal projects to nix
    cabal-install # package manager
    structured-haskell-mode
    ghc
    ghcid # compiler
    haskell-language-server # haskell IDE (ships with ghcide)
    dhall-lsp-server
    hoogle # documentation
    hlint
    hpack
    implicit-hie # hie
    hie-bios
    niv
    nix-tree # visualize nix dependencies
    ormolu
    stylish-haskell
  ];
  rustPkgs = with pkgs; [ rustup ];

  polybarPkgs = with pkgs; [
    font-awesome-ttf # awesome fonts
    material-design-icons # fonts with glyphs
  ];

  scripts = pkgs.callPackage ./scripts/default.nix { inherit config pkgs; };

  xmonadPkgs = with pkgs; [
    networkmanager_dmenu # networkmanager on dmenu
    networkmanagerapplet # networkmanager applet
    nitrogen # wallpaper manager
    xcape # keymaps modifier
    xorg.xkbcomp # keymaps modifier
    xorg.xmodmap # keymaps modifier
    xorg.xrandr # display manager (X Resize and Rotate protocol)
  ];

in {
  programs.home-manager.enable = true;

  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = p: {
      nur = import (import pinned/nur.nix) { inherit pkgs; };
    };
  };

  nixpkgs.overlays = [ (import ./overlays/beauty-line) ];

  imports = (import ./programs) ++ (import ./services) ++ [ (import ./themes) ];

  xdg.enable = true;

  home = {
    username = "soostone";
    homeDirectory = "/home/soostone";
    stateVersion = "21.11";

    packages = defaultPkgs ++ gitPkgs ++ gnomePkgs ++ nodePkgs ++ pythonPkgs
      ++ haskellPkgs ++ rustPkgs ++ polybarPkgs ++ scripts ++ xmonadPkgs;

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
      enableBashIntegration = true;
    };


    fzf = {
      enable = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
    };

    # gpg.enable = true;

    htop = {
      enable = true;
    };

    zsh = { enable = true; };

    jq.enable = true;
    # ssh.enable = true;

  };

  services = {
    flameshot.enable = true;
    lorri.enable = true;
    # xscreensaver = {enable = true; settings = { lock = true; };};
  };

}
