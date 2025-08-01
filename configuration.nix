{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Enabling flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Novosibirsk";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # CUDA 
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  hardware.nvidia.prime = {
    offload = {
      enable = true;
      enableOffloadCmd = true;
    };
    intelBusId = "PCI:0:2:0"; # pci@0000:00:02.0
    nvidiaBusId = "PCI:1:0:0"; # pci@0000:01:00.0
  };
  # Intel opencl
  hardware.graphics = {
    enable = true;
    extraPackages = [ pkgs.intel-compute-runtime pkgs.ocl-icd pkgs.intel-ocl ];
  };

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  #services.xserver.displayManager.gdm.wayland = false;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # NTFS
  boot.supportedFilesystems = [ "ntfs" ];
  fileSystems."/home/glebd/Data" =
    {
      device = "/dev/disk/by-uuid/5252D85E52D847FD";
      fsType = "ntfs-3g";
      options = [ "rw" "uid=1000" "nofail" ];
    };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # zsh
  programs.zsh.enable = true;

  #fonts.packages = with pkgs; [
  #  (nerdfonts.override { fonts = [ "DejaVuSansMono" ]; })
  #];
  fonts.packages = [
    pkgs.nerd-fonts.dejavu-sans-mono
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.glebd = {
    isNormalUser = true;
    description = "Gleb Dovzhenko";
    extraGroups = [ "networkmanager" "wheel" "dialout" ];
    shell = pkgs.zsh;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    remmina
    freerdp
    intel-ocl
    clinfo
    home-manager
    lshw
    pciutils
    pavucontrol
    gnome-tweaks
    cudaPackages.cudatoolkit
    gparted
    efibootmgr
    # various
    chromium
    telegram-desktop
    obsidian
    zotero
    # cli
    wget
    #alacritty
    tmux
    #neovim
    htop
    zoxide
    pass
    gnupg
    fzf
    ripgrep
    fd
    lazygit
    # dev
    git
    gnumake
    gcc
    clang-tools
    gdb
    pyright
    go
    gopls
    python3
    black
    nodejs_22
    lua
    luajit
    luajitPackages.luarocks
    luajitPackages.lua-lsp
    lua-language-server
    nixpkgs-fmt
    wl-clipboard
    libreoffice
    rustup
    nixd
    hiddify-app
    bat
    glow
    texliveFull
    inkscape-with-extensions
    wayland-scanner
  ];

  #nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  programs.firefox.enable = true;

  environment.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";

    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
    # GTK apps started dying at some point and this is a fix 
    GSK_RENDERER = "gl";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.udev.packages = [
    pkgs.platformio-core
    pkgs.openocd
  ];

  #services.udev.extraRules = ''
  #  SUBSYSTEMS==\"usb\", ATTRS{idVendor}==\"1a86\", ATTRS{idProduct}==\"7523\", GROUP=\"users\", MODE=\"0666\"\n
  #  SUBSYSTEMS==\"usb\", ATTRS{idVendor}==\"10c4\", ATTRS{idProduct}==\"ea60\", GROUP=\"users\", MODE=\"0666\"
  #'';

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

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
  system.stateVersion = "24.05"; # Did you read the comment?

}
