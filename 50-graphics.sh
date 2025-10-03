# packages
AddPackage adw-gtk-theme                      # Unofficial GTK 3 port of the libadwaita theme
AddPackage brightnessctl                      # Lightweight brightness control tool
AddPackage chafa                              # Image-to-text converter supporting a wide range of symbols and palettes, transparency, animations, etc.
AddPackage cliphist                           # wayland clipboard manager
AddPackage dconf-editor                       # GSettings editor for GNOME
AddPackage ffmpegthumbnailer                  # Lightweight video thumbnailer that can be used by file managers
AddPackage foot                               # Fast, lightweight, and minimalistic Wayland terminal emulator
AddPackage foot-terminfo                      # Extra non-standard terminfo files for foot, a Wayland terminal emulator
AddPackage fuzzel                             # Application launcher for wlroots based Wayland compositors
AddPackage --foreign easyeffects-git          # Audio Effects for PipeWire applications
AddPackage grim                               # Screenshot utility for Wayland
AddPackage hypridle                           # hyprland’s idle daemon
AddPackage hyprland                           # a highly customizable dynamic tiling Wayland compositor
AddPackage hyprlock                           # hyprland’s GPU-accelerated screen locking utility
AddPackage hyprpaper                          # a blazing fast wayland wallpaper utility with IPC controls
AddPackage hyprpicker                         # A wlroots-compatible Wayland color picker that does not suck
AddPackage hyprpolkitagent                    # Simple polkit authentication agent for Hyprland, written in QT/QML
AddPackage kvantum                            # SVG-based theme engine for Qt6 (including config tool and extra themes)
AddPackage lsp-plugins-lv2                    # Collection of open-source plugins - LV2
AddPackage mako                               # Lightweight notification daemon for Wayland
AddPackage mesa-utils                         # Essential Mesa utilities
AddPackage mpv                                # a free, `open source, and cross-platform media player
AddPackage networkmanager-dmenu               # control networkmanager via dmenu-compatible launcher
AddPackage nm-connection-editor               # NetworkManager GUI connection editor and widgets
AddPackage papirus-icon-theme                 # Papirus icon theme
AddPackage poppler                            # PDF rendering library based on xpdf 3.0
AddPackage seahorse                           # GNOME application for managing PGP keys
AddPackage slurp                              # Select a region in a Wayland compositor
AddPackage swayimg                            # A lightweight image viewer for Wayland display servers
AddPackage uwsm                               # A standalone Wayland session manager
AddPackage vulkan-tools                       # Vulkan Utilities and Tools
AddPackage waybar                             # Highly customizable Wayland bar for Sway and Wlroots based compositors
AddPackage xdg-desktop-portal-gtk             # A backend implementation for xdg-desktop-portal using GTK
AddPackage xdg-desktop-portal-hyprland        # xdg-desktop-portal backend for hyprland
AddPackage xdg-user-dirs                      # Manage user directories like ~/Desktop and ~/Music
AddPackage --foreign catppuccin-cursors-mocha # Soothing pastel mouse cursors - Mocha
AddPackage --foreign hyprqt6engine            # QT6 theme provider for Hyprland
AddPackage --foreign matugen-bin              # A material you color generation tool with templates
AddPackage --foreign mullvad-vpn-bin          # The Mullvad VPN client app for desktop
AddPackage --foreign mpd-notification         # Notify about tracks played by mpd
AddPackage --foreign papirus-folders          # Allows changing the color of folders in Papirus icon theme and its forks
AddPackage --foreign poweralertd              # UPower-powered power alerter
AddPackage --foreign visual-studio-code-bin   # Visual Studio Code (vscode): Editor for building and debugging modern web and cloud applications (official binary version)
AddPackage --foreign sunsetr-bin              # Automatic blue light filter for Hyprland, Niri, and everything Wayland (pre-compiled binary)

# mullvad-vpn
SetFileProperty /usr/bin/mullvad-exclude mode 4755

# systemd enable
CreateLink /etc/systemd/system/dbus-org.freedesktop.nm-dispatcher.service /usr/lib/systemd/system/NetworkManager-dispatcher.service
CreateLink /etc/systemd/system/multi-user.target.wants/NetworkManager.service /usr/lib/systemd/system/NetworkManager.service
CreateLink /etc/systemd/system/network-online.target.wants/NetworkManager-wait-online.service /usr/lib/systemd/system/NetworkManager-wait-online.service
CreateLink /etc/systemd/user/graphical-session-pre.target.wants/xdg-user-dirs.service /usr/lib/systemd/user/xdg-user-dirs.service
CreateLink /etc/systemd/system/mullvad-daemon.service.wants/mullvad-early-boot-blocking.service /usr/lib/systemd/system/mullvad-early-boot-blocking.service
CreateLink /etc/systemd/system/multi-user.target.wants/mullvad-daemon.service /usr/lib/systemd/system/mullvad-daemon.service
