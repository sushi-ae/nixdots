{ config, pkgs, ... }:

{
  imports =
    [ # hardware scan.
      ./hardware-configuration.nix
    ];

  # oh yes systemd.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixpad"; # the waffle house has found it's new host.
  # wifi no way
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # we need a zone for time.
  time.timeZone = "Asia/Manila";

  # Xorg still exists fr
  services.xserver = {
      enable = true;
      layout = "us";
      autorun = true;
      displayManager.lightdm.enable = true;
      desktopManager.xfce.enable = true;
      displayManager.defaultSession = "none+bspwm";
      desktopManager.xterm.enable = false;
  };
  
  # bspwm
  services.xserver.windowManager.bspwm = {
      enable = true;
      configFile = "/home/thirst/.config/bspwm/bspwmrc";
      sxhkd.configFile = "/home/thirst/.config/sxhkd/sxhkdrc";
      package = pkgs.bspwm;
  };

  # I think this is for USBs?
  fileSystems."/data" = 
    { device = "/dev/disk/by-label/data";
      fsType = "ext4";
      options = [ "nofail" ];
    };
  

  # we do not need to print at this moment.
  # services.printing.enable = true;

  # we need to hear stuff.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # we need trackpad or else no laptop work.
  services.xserver.libinput.enable = true;

  # you need a user right.
  users.users.thirst = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [];
  };
 
  # packages
  environment.systemPackages = with pkgs; [
    # uhh
    vim
    wget
    
    # wm
    bspwm
    sxhkd
    picom
 
    # a
    alacritty
    polybar
    cava 
    git   
    hyfetch
    chromium
    cinnamon.nemo
    lxappearance

    # misc
    acpi
    scrot
    flameshot 
    doas   
    feh
    nitrogen
    exa 

    # what
    xorg.xinit
    lightdm

    # whathwahthwaht
    cope
    raylib
    dosbox
    tlp
    gcc
    cargo 
  ];
  
  # fonts because we need text gud.
  fonts.fonts = with pkgs; [
      tamzen
      #(nerdfonts.override { fonts = [ "CascadiaCode" "Iosevka" ]; })
  ];

  # List services that you want to enable:

  # enable openssh, whatever that is.
  services.openssh.enable = true;

  # haha no firewall cry about it.
  networking.firewall.enable = false;

  # this copies the config so that if you become a nitwit
  # the file will be restored.
  system.copySystemConfiguration = true;

  # why am I using a racoon
  system.stateVersion = "22.11"; # Did you read the comment?

}

