{
  config,
  pkgs,
  nixpkgs,
  ...
}: {
  system.stateVersion = 4;
  services.nix-daemon.enable = true;

  nix = {
    gc = {
      automatic = true;
      interval.Day = 7;
      options = "--delete-older-than 7d";
    };
    package = pkgs.nixUnstable;
    settings.auto-optimise-store = true;
    extraOptions = ''
      experimental-features = nix-command flakes
      extra-nix-path = nixpkgs=flake:nixpkgs
    '';
  };

  environment = {
    shells = [pkgs.fish];
    loginShell = pkgs.fish;
  };

  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [
    iosevka-bin
    (nerdfonts.override {
      fonts = ["NerdFontsSymbolsOnly"];
    })
  ];

  homebrew = {
    enable = true;
    caskArgs.no_quarantine = true;
    global.brewfile = true;
    taps = [];
    brews = [];
    casks = [
      "1password"
      "aldente"
      "arc"
      "backblaze"
      "buckets"
      "calibre"
      "cheatsheet"
      "coconutbattery"
      "deepl"
      "docker"
      "firefox"
      "github"
      "gitup"
      "gpg-suite"
      "jdownloader"
      "keka"
      "keyboardcleantool"
      "kindle"
      "lapce"
      "moneymoney"
      "moom"
      "netnewswire"
      "nvidia-geforce-now"
      "orion"
      "portfolioperformance"
      "raspberry-pi-imager"
      "raycast"
      "signal"
      "steam"
      "sublime-merge"
      "sublime-text"
      "syntax-highlight"
      "transmission"
      "utm"
      "xcodes"
      "ytmdesktop-youtube-music"
      "zoom"
    ];
    masApps = {
      "1Blocker" = 1365531024;
      "1Password for Safari" = 1569813296;
      "Affinity Photo" = 824183456;
      Agenda = 1287445660;
      AusweisApp2 = 948660805;
      Bear = 1091189122;
      Cascadea = 1432182561;
      Consent-O-Matic = 1606897889;
      CotEditor = 1024640650;
      Darkroom = 953286746;
      Developer = 640199958;
      FakespotSafari = 1592541616;
      Fantastical = 975937182;
      GameTrack = 1136800740;
      GoodNotes = 1444383602;
      Grocery = 1195676848;
      Keynote = 409183694;
      LanguageTool = 1534275760;
      Mela = 1568924476;
      MusicHarbor = 1440405750;
      NepTunes = 1006739057;
      Numbers = 409203825;
      Pages = 409201541;
      "Pixelmator Pro" = 1289583905;
      Reeder = 1529448980;
      StopTheMadness = 1376402589;
      Telegram = 747648890;
      TestFlight = 899247664;
      Things = 904280696;
      WhatsApp = 1147396723;
    };
    onActivation.cleanup = "uninstall";
  };

  launchd.user.agents.nix-index = {
    command = pkgs.nix-index + /bin/nix-index;
    serviceConfig = {
      ExitTimeOut = 15 * 60; # seconds -> 15min
      ProcessType = "Background";
      StartInterval = 60 * 60 * 24 * 7; # seconds -> every 7 days
      # debugging, remove later
      StandardErrorPath = "/Users/bene/nix-index-error.log";
      StandardOutPath = "/Users/bene/nix-index-out.log";
    };
  };

  programs.bash.enable = true;
  programs.fish = {
    enable = true;
    useBabelfish = true;
    babelfishPackage = pkgs.babelfish;
  };
  programs.zsh.enable = true;

  system.defaults = {
    CustomSystemPreferences = {
      "com.apple.TextEdit".RichText = 0;
    };
    dock = {
      autohide = true;
      autohide-delay = 0.0;
    };
    finder = {
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      FXEnableExtensionChangeWarning = false;
      FXPreferredViewStyle = "clmv"; # column view by default
      ShowPathbar = true;
      ShowStatusBar = true;
    };
    NSGlobalDomain = {
      "com.apple.keyboard.fnState" = true; # Fn keys are F1-12
      AppleKeyboardUIMode = 3; # full keyboard control of dialogs
      AppleShowAllExtensions = true;
      NSNavPanelExpandedStateForSaveMode = true;
      NSNavPanelExpandedStateForSaveMode2 = true;
    };
    screencapture = {
      disable-shadow = true;
      location = "$HOME/Desktop";
      type = "png";
    };
  };
  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
  };

  security.pam.enableSudoTouchIdAuth = true;

  users.users.bene = {
    home = "/Users/bene";
    shell = pkgs.fish;
  };
}
