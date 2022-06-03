# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

  nix = {
      autoOptimiseStore = true;
      gc = {
            automatic = true;
            dates = "weekly";
            options = "--delete-older-than 30d";
      };
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
      interfaces.enp7s0.useDHCP = false;
      interfaces.wlp6s0.useDHCP = true;
      };
  };

  environment.variables = {
      NIXOS_CONFIG = "$HOME/.config/nixos/configuration.nix";
      NIXOS_CONFIG_DIR = "$HOME/.config/nixos/";
      XDG_DATA_HOME = "$HOME/.local/share";
      PASSWORD_STORE_DIR = "$HOME/.local/share/password-store";
      GTK_RC_FILES = "$HOME/.local/share/gtk-1.0/gtkrc";
      GTK2_RC_FILES = "$HOME/.local/share/gtk-2.0/gtkrc";
      EDITOR = "nvim";
      DIRENV_LOG_FORMAT = "";
      MANPAGER = "nvim +Man!";
      BROWSER = "firefox";
      LYNX_CFG="$HOME/.config/lynx/lynx.cfg";
      LYNX_LSS="$HOME/.config/lynx/lynx.lss";
  };

  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };
  
  #Do not touch
  system.stateVersion = "21.11"; # Did you read the comment?

}

