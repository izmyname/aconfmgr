IgnorePath '/.*'
IgnorePath '/boot/*'
IgnorePath '/etc/ca-certificates/*'
IgnorePath '/var/lib/pacman/local/*'
IgnorePath '/var/lib/systemd/coredump/*'
IgnorePath '/var/*'
IgnorePath '/usr/share/mime/text/*'
IgnorePath '/swp/swapfile'
IgnorePath '/etc/pacman.d/gnupg/*'
IgnorePath '/var/log/*'
IgnorePath '/usr/share/mime/*'
IgnorePath '/var/lib/mlocate/mlocate.db'
IgnorePath '/var/lib/dkms/*'
IgnorePath '/usr/lib/modules/*'
IgnorePath '/usr/lib/udev/hwdb.bin'
IgnorePath '/etc/mkinitcpio.conf'     # use mkinitcpio.d
IgnorePath '/etc/systemd/logind.conf' # use logind.conf.d
IgnorePath '/etc/NetworkManager/*'
IgnorePath '/etc/fonts/*'
IgnorePath '/etc/sgml/*'
IgnorePath '/etc/ssl/*'
IgnorePath '/etc/localtime' # ln -sf /usr/share/info/Zone/Subzone /etc/localtime
IgnorePath '/etc/ufw/*'     # ufw won't install if there are any ufw configs on the system
IgnorePath '/etc/os-release'
IgnorePath '/etc/.*'
IgnorePath '/etc/*.cache'
IgnorePath '/etc/machine-id'
IgnorePath '/var/tmp/*'
IgnorePath '/usr/lib/*/*cache'
IgnorePath '/usr/lib/locale/*'
IgnorePath '/usr/lib/graphviz/*'
IgnorePath '/usr/share/*'
IgnorePath '/etc/fstab' # genfstab -U /mnt
IgnorePath '/etc/default/*'
IgnorePath '/etc/mullvad-vpn/*'
IgnorePath '/etc/resolv.conf*'
IgnorePath '/etc/pacman.d/mirrorlist'
IgnorePath '/etc/vconsole.conf'
IgnorePath '/etc/systemd/system.conf' # use system.conf.d
IgnorePath '/etc/crypttab'
IgnorePath '/etc/adjtime' # run hwclock --systohc
IgnorePath '/etc/shells'

#don't save sensitive information
IgnorePath '/etc/passwd*'
IgnorePath '/etc/group*'
IgnorePath '/etc/shadow*'
IgnorePath '/etc/gshadow*'
IgnorePath '/etc/subuid*'
IgnorePath '/etc/subgid*'