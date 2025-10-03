# packages
AddPackage base                          # Minimal package set to define a basic Arch Linux installation
AddPackage base-devel                    # Basic tools to build Arch Linux packages
AddPackage bash-completion               # Programmable completion for the bash shell
AddPackage dhclient                      # A standalone DHCP client from the dhcp package
AddPackage dosfstools                    # DOS filesystem utilities
AddPackage dmidecode                     # Desktop Management Interface table related utilities
AddPackage efibootmgr                    # Linux user-space application to modify the EFI Boot Manager
AddPackage efitools                      # Tools for manipulating UEFI secure boot platforms
AddPackage ethtool                       # Utility for controlling network drivers and hardware
AddPackage exfatprogs                    # exFAT filesystem userspace utilities for the Linux Kernel exfat driver
AddPackage flatpak                       # Linux application sandboxing and distribution framework (formerly xdg-app)
AddPackage fwupd                         # Simple daemon to allow session software to update firmware
AddPackage git                           # the fast distributed version control system
AddPackage iwd                           # Internet Wireless Daemon
AddPackage logrotate                     # Rotates system logs automatically
AddPackage linux-firmware                # Firmware files for Linux
AddPackage linux-zen                     # The Linux ZEN kernel and modules
AddPackage linux-zen-headers             # Headers and scripts for building modules for the Linux ZEN kernel
AddPackage neovim                        # Fork of Vim aiming to improve user experience, plugins, and GUIs
AddPackage nfs-utils                     # Support programs for Network File Systems
AddPackage ntfs-3g                       # NTFS filesystem driver and utilities
AddPackage rebuild-detector              # Detects which packages need to be rebuilt
AddPackage reflector                     # A Python 3 module and script to retrieve and filter the latest Pacman mirror list.
AddPackage sg3_utils                     # Generic SCSI utilities
AddPackage smartmontools                 # Control and monitor S.M.A.R.T. enabled ATA and SCSI Hard Drives
AddPackage snapper                       # A tool for managing BTRFS and LVM snapshots. It can create, diff and restore snapshots and provides timelined auto-snapping.
                                         # btrfs-progs is a snapper dependency. It will be pulled automatically.
AddPackage sbctl                         # Secure Boot key manager
AddPackage usb_modeswitch                # Activating switchable USB devices on Linux.
AddPackage --foreign aconfmgr-git        # A configuration manager for Arch Linux
AddPackage --foreign downgrade           # Bash script for downgrading one or more packages to a version in your cache or the A.L.A.
AddPackage --foreign yay                 # Yet another yogurt. Pacman wrapper and AUR helper written in go.
### zsh extensions
AddPackage zsh-autosuggestions           # Fish-like autosuggestions for zsh
AddPackage zsh-completions               # Additional completion definitions for Zsh
AddPackage zsh-history-substring-search  # ZSH port of Fish history search (up arrow)
AddPackage zsh-syntax-highlighting       # Fish shell like syntax highlighting for Zsh
AddPackage zoxide                        # A smarter cd command for your terminal
AddPackage --foreign zsh-pure-prompt     # Pretty, minimal and fast ZSH prompt
### ucode
AddPackage intel-ucode                   # Microcode update files for Intel CPUs

# set variables
UUID='02382d5a-8258-48af-8b13-87cc7fbe7157' # needed for kernel cmdline
#(useradd -m -G wheel,network,video,audio -s /usr/bin/zsh $username passwd $username)

# locale
cat >>"$(GetPackageOriginalFile glibc /etc/locale.gen)" <<EOF

# enabled locales
en_US.UTF-8 UTF-8
en_GB.UTF-8 UTF-8
ru_RU.UTF-8 UTF-8
EOF

cat >"$(CreateFile /etc/locale.conf)" <<EOF
LANG=C.UTF-8
EOF

# hostname
cat >"$(CreateFile /etc/hostname)" <<EOF
archbtw
EOF

# install kernel

## set kernel parameters
cat >"$(CreateFile /etc/kernel/cmdline)" <<EOF
init=/usr/lib/systemd/systemd rd.luks.name=$UUID=root root=/dev/mapper/root rd.luks.options=discard rootflags=subvol=@,compress=zstd:3 nowatchdog rw quiet bgrt_disable
EOF

## mkinitcpio - set hooks

### hooks - no kms (for nvidia gpu)
cat >"$(CreateFile /etc/mkinitcpio.conf.d/30-hooks-no-kms.conf)" <<EOF
HOOKS=(systemd autodetect microcode modconf keyboard sd-vconsole block sd-encrypt filesystems)
EOF

### hooks -  kms
#cat >"$(CreateFile /etc/mkinitcpio.conf.d/30-hooks.conf)" <<EOF
#HOOKS=(systemd autodetect microcode modconf kms keyboard sd-vconsole block sd-encrypt filesystems)
#EOF

## mkinitcpio - configure linux-zen preset to create Unified Kernel Image
cat >"$(CreateFile /etc/mkinitcpio.d/linux-zen.preset)" <<EOF
# mkinitcpio preset file for the 'linux-zen' package

ALL_kver="/boot/vmlinuz-linux-zen"

PRESETS=('default')

default_uki="/boot/EFI/Linux/arch-linux-zen.efi"
default_options="--splash /usr/share/systemd/bootctl/splash-arch.bmp"
EOF

# pacman
f="$(GetPackageOriginalFile pacman /etc/pacman.conf)"

## set variables for easier editing
ignorepkg='xorg-server'
ignoregroup='xorg'

## options
sed -i "/^# Misc options/ a ILoveCandy" "$f" #enable an easter egg
#sed -i "s/^#IgnorePkg/IgnorePkg/; /IgnorePkg/ s/$/ ${ignorepkg}/" "$f"                                    #ignore packages
#sed -i "s/^#IgnoreGroup/IgnoreGroup/; /IgnoreGroup/ s/$/ ${ignoregroup}/" "$f"                            #ignore package groups
sed -i "s/^#Color/Color/" "$f"                     #colored output
sed -i "s/^#VerbosePkgLists/VerbosePkgLists/" "$f" #some verbosity

##  enable testing repos
#sed -i "/\[core-testing\]/,/Include/"'s/^#//' "$f"
#sed -i "/\[extra-testing\]/,/Include/"'s/^#//' "$f"

## enable multilib
#sed -i "/\[multilib-testing\]/,/Include/"'s/^#//' "$f"
#sed -i "/\[multilib\]/,/Include/"'s/^#//' "$f"

## append to pacman.conf
cat >>"$(GetPackageOriginalFile --no-clobber pacman /etc/pacman.conf)" <<EOF

### managed by aconfmgr
EOF

# blacklist unneeded modules
cat >"$(CreateFile /etc/modprobe.d/blacklist.conf)" <<EOF
blacklist uvcvideo  # disable webcam
blacklist iTCO_wdt  # disable watchdog timer
EOF

# fuse
cat >"$(CreateFile /etc/fuse.conf)" <<EOF
# The file /etc/fuse.conf allows for the following parameters:
#
# user_allow_other - Using the allow_other mount option works fine as root, but
# in order to have it work as a regular user, you need to set user_allow_other
# in /etc/fuse.conf as well. This option allows non-root users to use the
# allow_other option. You need allow_other if you want users other than the
# owner of a mounted fuse to access it. This option must appear on a line by
# itself. There is no value; just the presence of the option activates it.

user_allow_other


# mount_max = n - this option sets the maximum number of mounts.
# It must be typed exactly as shown (with a single space before and after the
# equals sign).

#mount_max = 1000
EOF

# environment
cat >"$(CreateFile /etc/environment)" <<EOF
EDITOR=nvim
VISUAL=nvim
EOF

# reflector
cat >"$(CreateFile /etc/xdg/reflector/reflector.conf)" <<EOF
--save /etc/pacman.d/mirrorlist
--country France,Germany,Netherlands,Sweden 
--protocol https
--latest 5
--sort age 
EOF

# sudo
cat >"$(CreateFile /etc/sudoers.d/wheel 640)" <<EOF
%wheel ALL=(ALL:ALL) ALL
EOF

# shadow
SetFileProperty /usr/bin/groupmems group groups
SetFileProperty /usr/bin/groupmems mode 2750

# snapper
CopyFile /etc/snapper/configs/root 640
CopyFile /etc/conf.d/snapper

# systemd overrides

## fstrim.service
cat >"$(CreateFile /etc/systemd/system/fstrim.service.d/override.conf)" <<EOF
 [Unit]
 Description=Discard unused blocks on filesystems

 [Service]
# /boot is automounted by systemd with 2min idle timeout. Calling fstrim for /boot ensures it will be mounted.
 ExecStart=/usr/bin/fstrim /boot --verbose --quiet-unsupported
# / isn't listed in fstab.
 ExecStart=/usr/bin/fstrim / --verbose --quiet-unsupported
EOF

## paccache.service
cat >"$(CreateFile /etc/systemd/system/paccache.service.d/override.conf)" <<EOF
[Service]
ExecStart=/usr/bin/paccache -rk0
EOF

## getty@tty1.service - partial autologin
cat >"$(CreateFile /etc/systemd/system/getty@tty1.service.d/skip-password.conf)" <<EOF
[Service]
ExecStart=
ExecStart=-/usr/bin/agetty -o '-p -- $USER' --noclear --skip-login - \$TERM
EOF

# systemd enable
CreateLink /etc/systemd/system/dbus-org.freedesktop.Avahi.service /usr/lib/systemd/system/avahi-daemon.service
CreateLink /etc/systemd/system/dbus-org.freedesktop.timesync1.service /usr/lib/systemd/system/systemd-timesyncd.service
CreateLink /etc/systemd/system/getty.target.wants/getty@tty1.service /usr/lib/systemd/system/getty@.service
CreateLink /etc/systemd/system/multi-user.target.wants/avahi-daemon.service /usr/lib/systemd/system/avahi-daemon.service
CreateLink /etc/systemd/system/multi-user.target.wants/remote-fs.target /usr/lib/systemd/system/remote-fs.target
CreateLink /etc/systemd/system/sockets.target.wants/avahi-daemon.socket /usr/lib/systemd/system/avahi-daemon.socket
CreateLink /etc/systemd/system/sockets.target.wants/systemd-userdbd.socket /usr/lib/systemd/system/systemd-userdbd.socket
CreateLink /etc/systemd/system/sysinit.target.wants/systemd-timesyncd.service /usr/lib/systemd/system/systemd-timesyncd.service
CreateLink /etc/systemd/system/timers.target.wants/fstrim.timer /usr/lib/systemd/system/fstrim.timer
CreateLink /etc/systemd/system/timers.target.wants/reflector.timer /usr/lib/systemd/system/reflector.timer
CreateLink /etc/systemd/system/timers.target.wants/snapper-boot.timer /usr/lib/systemd/system/snapper-boot.timer
CreateLink /etc/systemd/system/timers.target.wants/snapper-cleanup.timer /usr/lib/systemd/system/snapper-cleanup.timer
CreateLink /etc/systemd/system/timers.target.wants/snapper-timeline.timer /usr/lib/systemd/system/snapper-timeline.timer
CreateLink /etc/systemd/user/sockets.target.wants/p11-kit-server.socket /usr/lib/systemd/user/p11-kit-server.socket
CreateLink /etc/systemd/system/timers.target.wants/paccache.timer /usr/lib/systemd/system/paccache.timer
