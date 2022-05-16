# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];


  nix = {
        package = pkgs.nixUnstable;
        extraOptions = ''
            experimental-features = nix-command flakes
            keep-outputs = true
            keep-derivations = true
        '';
    };

  boot = {
      cleanTmpDir = true;
      loader = {
      systemd-boot.enable = true;
      systemd-boot.editor = false;
      efi.canTouchEfiVariables = true;
      timeout = 0;
      };
  };

  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
      font = "Lat2-Terminus16";
      keyMap = "us";
  };

  users.users.prabakaran = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      shell = pkgs.zsh;
  };

  networking = {
      hostName = "nixos";
      networkmanager.enable = true;
      interfaces.enp0s25.useDHCP = false;
      interfaces.wlp6s0.useDHCP = true;
      };
  };

  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };

  services.xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.plasma5.enable = true;
      windowManager.bspwm.enable = true;
      libinput.enable = true;
    };

  nixpkgs.config.allowUnfree = true;

  services.xserver.layout = "us";
  hardware = {
      pulseaudio.enable = true;
      bluetooth.enable = true;
    };

  sound.enable = true;
  security.rtkit.enable = true;

  fonts = {
      fonts = with pkgs; [
          jetbrains-mono
          roboto
          (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
      ];
      fontconfig.hinting.autohint = true;
  };

  networking.extraHosts = let
  hostsPath = https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn-social/hosts;
  hostsFile = builtins.fetchurl { url=hostsPath; sha256="sha256:19bv72n8ili9h62k1pj3yqi6vx6j0vbrhb4qdy3wcxwj3ylqdg45"; };
  in builtins.readFile "${hostsFile}";

  hardware.cpu.intel.updateMicrocode = true;

  environment.systemPackages = with pkgs; [
    neovim
    vim
    wget
    firefox
    pfetch
    git
    nitrogen
    sxiv
    picom
    bspwm
    sxhkd
    alacritty
    kitty
    curl
    zsh
    polybar
    rofi
    dmenu
    dunst
    pavucontrol
    maim
    killall
    xclip
    ffmpeg
    mpv
    gnome-breeze
    lxappearance
    unzip
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?

}

