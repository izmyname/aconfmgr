# packages
AddPackage aria2                # Download utility that supports HTTP(S), FTP, BitTorrent, and Metalink
AddPackage alsa-firmware        # Firmware binaries for loader programs in alsa-tools and hotplug firmware loader
AddPackage atool                # A script for managing file archives of various types
AddPackage bat                  # Cat clone with syntax highlighting and git integration
AddPackage chezmoi              # Manage your dotfiles across multiple machines
AddPackage dua-cli              # A tool to conveniently learn about the disk usage of directories, fast!
AddPackage duf                  # Disk Usage/Free Utility
AddPackage duperemove           # Btrfs extent deduplication utility
AddPackage fd                   # Simple, fast and user-friendly alternative to find
AddPackage geoip                # Non-DNS IP-to-country resolver C library & utils
AddPackage geoip-database-extra # GeoIP legacy city/ASN databases (based on GeoLite2 data created by MaxMind)
AddPackage gnome-keyring        # Stores passwords and encryption keys
AddPackage gst-libav            # Multimedia graph framework - libav plugin
AddPackage gst-plugin-pipewire  # Multimedia graph framework - pipewire plugin
AddPackage gst-plugins-bad      # Multimedia graph framework - bad plugins
AddPackage gst-plugins-base     # Multimedia graph framework - base plugins
AddPackage gst-plugins-good     # Multimedia graph framework - good plugins
AddPackage gst-plugins-ugly     # Multimedia graph framework - ugly plugins
AddPackage gvfs-mtp             # Virtual filesystem implementation for GIO - MTP backend (Android, media player)
AddPackage haveged              # Entropy harvesting daemon using CPU timings
AddPackage hdparm               # A shell utility for manipulating Linux IDE drive/driver parameters
AddPackage htop                 # Interactive process viewer
AddPackage hunspell             # Spell checker and morphological analyzer library and program
AddPackage hunspell-en_us       # US English hunspell dictionaries
AddPackage hunspell-ru          # Russian dictionary for Hunspell
AddPackage inxi                 # Full featured CLI system information tool
AddPackage jq                   # Command-line JSON processor
AddPackage libqalculate         # Multi-purpose desktop calculator
AddPackage lsd                  # Modern ls with a lot of pretty colors and awesome icons
AddPackage lsscsi               # A tool that lists devices connected via SCSI and its transports
AddPackage man-db               # A utility for reading man pages
AddPackage man-pages            # Linux man pages
AddPackage mediainfo            # Supplies technical and tag information about media files (CLI interface)
AddPackage mpc                  # Minimalist command line interface to MPD
AddPackage mpd                  # Flexible, powerful, server-side application for playing music
AddPackage 7zip                 # File archiver for extremely high compression
AddPackage pipewire-alsa        # Low-latency audio/video router and processor - ALSA configuration
AddPackage pipewire-pulse       # Low-latency audio/video router and processor - PulseAudio replacement
AddPackage pkgstats             # Submit a list of installed packages to the Arch Linux project
AddPackage postgresql           # Sophisticated object-relational DBMS
AddPackage rclone               # Sync files to and from Google Drive, S3, Swift, Cloudfiles, Dropbox and Google Cloud Storage
AddPackage ripgrep              # A search tool that combines the usability of ag with the raw speed of grep
AddPackage rmpc                 # A beautiful and configurable TUI client for MPD
AddPackage rsync                # A fast and versatile file copying tool for remote and local files
AddPackage sof-firmware         # Sound Open Firmware
AddPackage taskwarrior-tui      # A terminal user interface for taskwarrior
AddPackage translate-shell      # A command-line interface and interactive shell for Google Translate
AddPackage trash-cli            # Command line trashcan (recycle bin) interface
AddPackage ufw                  # Uncomplicated and easy to use CLI tool for managing a netfilter firewall
AddPackage unrar                # The RAR uncompression program
AddPackage unzip                # For extracting and viewing files in .zip archives
AddPackage wget                 # Network utility to retrieve files from the Web
AddPackage whois                # Intelligent WHOIS client
AddPackage yazi                 # Blazing fast terminal file manager written in Rust, based on async I/O
AddPackage yt-dlp               # A youtube-dl fork with additional features and fixes
### fonts
AddPackage noto-fonts        # Google Noto TTF fonts
AddPackage noto-fonts-cjk    # Google Noto fonts for Japanese, Korean and Chinese languages
AddPackage noto-fonts-emoji  # Google Noto emoji fonts
AddPackage otf-font-awesome  # Iconic font designed for Bootstrap
AddPackage ttf-firacode-nerd # Patched font Fira (Fura) Code from nerd fonts library

# setup gnome-keyring with tty-login
cat >"$(CreateFile /etc/pam.d/login)" <<EOF
#%PAM-1.0

auth       required     pam_securetty.so
auth       requisite    pam_nologin.so
auth       include      system-local-login
auth       optional     pam_gnome_keyring.so
account    include      system-local-login
session    include      system-local-login
session    optional     pam_gnome_keyring.so auto_start
password   optional     pam_gnome_keyring.so
EOF

# workaround: setup gnome keyring secret portal to work with Hyprland
# requires aconfmgr apply on each gnome-keyring update
cat >"$(GetPackageOriginalFile gnome-keyring /usr/share/xdg-desktop-portal/portals/gnome-keyring.portal)" <<EOF
[portal]
DBusName=org.freedesktop.secrets
Interfaces=org.freedesktop.impl.portal.Secret
UseIn=gnome;hyprland
EOF

# systemd enable
CreateLink /etc/systemd/system/multi-user.target.wants/ufw.service /usr/lib/systemd/system/ufw.service
CreateLink /etc/systemd/system/sysinit.target.wants/haveged.service /usr/lib/systemd/system/haveged.service
CreateLink /etc/systemd/user/pipewire-session-manager.service /usr/lib/systemd/user/wireplumber.service
CreateLink /etc/systemd/user/pipewire.service.wants/wireplumber.service /usr/lib/systemd/user/wireplumber.service
CreateLink /etc/systemd/user/sockets.target.wants/pipewire-pulse.socket /usr/lib/systemd/user/pipewire-pulse.socket
CreateLink /etc/systemd/user/sockets.target.wants/pipewire.socket /usr/lib/systemd/user/pipewire.socket
CreateLink /etc/systemd/user/sockets.target.wants/gnome-keyring-daemon.socket /usr/lib/systemd/user/gnome-keyring-daemon.socket
