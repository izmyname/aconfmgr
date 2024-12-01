# packages
AddPackage adw-gtk-theme                      # Unofficial GTK 3 port of the libadwaita theme
AddPackage brightnessctl                      # Lightweight brightness control tool
AddPackage chafa                              # Image-to-text converter supporting a wide range of symbols and palettes, transparency, animations, etc.
AddPackage chezmoi                            # Manage your dotfiles across multiple machines
AddPackage cliphist                           # wayland clipboard manager
AddPackage dconf-editor                       # GSettings editor for GNOME
AddPackage ffmpegthumbnailer                  # Lightweight video thumbnailer that can be used by file managers
AddPackage foot                               # Fast, lightweight, and minimalistic Wayland terminal emulator
AddPackage foot-terminfo                      # Extra non-standard terminfo files for foot, a Wayland terminal emulator
AddPackage fuzzel                             # Application launcher for wlroots based Wayland compositors
AddPackage grim                               # Screenshot utility for Wayland
AddPackage kvantum                            # SVG-based theme engine for Qt6 (including config tool and extra themes)
AddPackage lxqt-archiver                      # A simple & lightweight desktop-agnostic Qt file archiver
AddPackage mako                               # Lightweight notification daemon for Wayland
AddPackage mesa-utils                         # Essential Mesa utilities
AddPackage mpv                                # a free, open source, and cross-platform media player
AddPackage papirus-icon-theme                 # Papirus icon theme
AddPackage pcmanfm-qt                         # The LXQt file manager, Qt port of PCManFM
AddPackage poppler                            # PDF rendering library based on xpdf 3.0
AddPackage qt6ct                              # Qt 6 Configuration Utility
AddPackage slurp                              # Select a region in a Wayland compositor
AddPackage swayimg                            # A lightweight image viewer for Wayland display servers
AddPackage vkd3d                              # Direct3D 12 to Vulkan translation library By WineHQ
AddPackage vulkan-tools                       # Vulkan Utilities and Tools
AddPackage waybar                             # Highly customizable Wayland bar for Sway and Wlroots based compositors
AddPackage xdg-desktop-portal-gtk             # A backend implementation for xdg-desktop-portal using GTK
AddPackage --foreign catppuccin-cursors-mocha # Soothing pastel mouse cursors - Mocha
AddPackage --foreign hyprland-meta-git        # Meta package to install Hyprland and all related utilities
AddPackage --foreign mpd-notification         # Notify about tracks played by mpd
AddPackage --foreign mullvad-vpn-bin          # The Mullvad VPN client app for desktop
AddPackage --foreign networkmanager-dmenu-git # Control NetworkManager via dmenu
AddPackage --foreign papirus-folders          # Allows changing the color of folders in Papirus icon theme and its forks
AddPackage --foreign poweralertd              # UPower-powered power alerter
AddPackage --foreign tty-clock                # Digital clock in ncurses
AddPackage --foreign uwsm                     # A standalone Wayland session manager

# mullvad
SetFileProperty /usr/bin/mullvad-exclude mode 4755

# systemd enable
CreateLink /etc/systemd/system/mullvad-daemon.service.wants/mullvad-early-boot-blocking.service /usr/lib/systemd/system/mullvad-early-boot-blocking.service
CreateLink /etc/systemd/system/multi-user.target.wants/mullvad-daemon.service /usr/lib/systemd/system/mullvad-daemon.service
