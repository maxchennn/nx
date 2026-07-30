{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Networking
  networking.hostName = "alice";
  networking.networkmanager.enable = true;
  networking.firewall.trustedInterfaces = [ "virbr0" ];

  # Time & Locale
  time.timeZone = "Europe/Istanbul";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "trq";

  # X11
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
    xkb = {
      layout = "tr";
    };
    windowManager.awesome.enable = true;
  };

  # NVIDIA
  hardware.graphics.enable = true;
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  # Audio & Security
  security.polkit.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

  # Desktop Environment
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  programs.niri.enable = true;
  programs.hyprland.enable = true;

  # Flatpak and some apps
  services.flatpak.enable = true;
  programs.kdeconnect.enable = true;
  programs.i3lock.enable = true;
  security.pam.services.i3lock.enable = true;

  # Virtualisation
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  # User
  users.users.max = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "libvirtd"
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Packages
  environment.systemPackages = with pkgs; [
    alacritty
    i3lock-color
    xfce4-screenshooter
    scrot
    qt6Packages.qt6ct
    flameshot
    picom
    maim
    xclip
    awesome
    feh 
    polybar
    luaPackages.luafilesystem
    luaPackages.lgi
    kdePackages.extra-cmake-modules
    kdePackages.kwin
    qt6.qttools
    kdePackages.kconfigwidgets
    waybar
    pkg-config
    udev
    rustup
    vscode
    jdk17
    tree
    gcc
    go
    ani-cli
    libimobiledevice
    ifuse
    appimage-run
    neovim
    localsend
    swappy
    droidcam
    git
    wget
    curl
    matugen
    firefox
    papirus-icon-theme
    papirus-folders
    vlc
    gawk
    coreutils
    grim
    slurp
    playerctl
    kdePackages.qt5compat
    kdePackages.polkit-kde-agent-1
    brightnessctl
    cava
    cmatrix
    ags
    wireplumber
    fastfetch
    obsidian
    davinci-resolve
    kdePackages.kdenlive
    cargo
    rustc
    starship
    zoxide
    tty-clock
    obs-studio
    kitty
    eww
    jq
    socat
    mako
    quickshell
    rofi
    hyprland
    hyprland-qtutils
    hyprpaper
    awww
    hyprlock
    waypaper
  ];

  # Fonts
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-code
      fira-code
      inter
      noto-fonts
      noto-fonts-color-emoji
      font-awesome
    ];
    fontconfig.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
    config.common.default = "*";
  };

  # System version
  system.stateVersion = "26.05";
}
