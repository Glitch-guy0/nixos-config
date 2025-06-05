# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, unstablepkgs, ... }@inputs:

{
  imports =
    [ 
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "unknown"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users = {
    users = {
      glitch = {
        isNormalUser = true;
        initialPassword = "user";
        description = "glitch";
        extraGroups = [ "networkmanager" "wheel" "docker" ];
        packages = 
          with pkgs; [
            # Browsers and Applications
            anki
            brave
            obsidian

            # Development Tools
            code-cursor
            python3Full

            # File Sync
            syncthing

            # System Tools
            acpi
            btop
            file
            fzf

            # System Tools & Monitoring
            coolercontrol.coolercontrol-gui
            coolercontrol.coolercontrold
            powertop

            # Virtualization & Containers
            docker-compose
            docker_28
            virtualbox
          ] ++ (with unstablepkgs;[
            # IDE
            vscode
            vscode-extensions.ms-python.python
          ]
        );
      };
      hyprUser = {
        isNormalUser = true;
        initialPassword = "hypr";
        description = "hyprland testing user";
        extraGroups = [ "networkmanager" "wheel" ];
        packages = with unstablepkgs; [
          home-manager
          vscode
          brave
            hyprland
            hyprpaper
            hyprlock
            hypridle
            waybar
            wofi
            xdg-desktop-portal-hyprland
            grim
            slurp
            swappy
            wl-clipboard
            mako
            swww
        ];
      };
    };
  };

  virtualisation.docker.enable = true;
  virtualisation.virtualbox = {
    host.enableExtensionPack = true;
  };

  # Syncthing Configuration
  services.syncthing = {
    enable = true;
    user = "glitch";
    dataDir = "/home/glitch";
  };

  # # clight config ***
  # services.clight.enable = true;
  # location = {
  #   latitude = 0.0;
  #   longitude = 0.0;
  # };
  # # *******

  
  # Power Management Services
  powerManagement.powertop.enable = true;
  programs.coolercontrol.enable = true;
  services.power-profiles-daemon.enable = true;
  # fzf keybindings
  programs.fzf.keybindings = true;
  programs.fzf.fuzzyCompletion = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    git
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
