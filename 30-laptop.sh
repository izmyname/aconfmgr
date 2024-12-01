# packages
AddPackage bluetui     # TUI for managing bluetooth devices
AddPackage bluez-utils # Development and debugging utilities for the bluetooth protocol stack
AddPackage tlp         # Linux Advanced Power Management
# upower is installed as waybar dep later

# actions on lid closed
cat >"$(CreateFile /etc/systemd/logind.conf.d/lid.conf)" <<EOF
[Login]
HandleLidSwitch=suspend
HandleLidSwitchExternalPower=lock
LidSwitchIgnoreInhibited=no
EOF

# tlp config
cat >"$(CreateFile /etc/tlp.d/50-runtime-denylist.conf)" <<EOF
RUNTIME_PM_DRIVER_DENYLIST="mei_me nouveau radeon nvidia"
EOF

# upower
f="$(GetPackageOriginalFile upower /etc/UPower/UPower.conf)"
sed -i 's/^ UsePercentageForPolicy=[^ ]*/UsePercentageForPolicy=true/' "$f"
sed -i 's/^PercentageLow=[^ ]*/PercentageLow=30.0/' "$f"
sed -i 's/^PercentageCritical[^ ]*/PercentageCritical=15.0/' "$f"
sed -i 's/^PercentageAction=[^ ]*/PercentageAction=5.0/' "$f"
sed -i 's/^CriticalPowerAction=[^ ]*/CriticalPowerAction=PowerOff/' "$f"

# systemd enable
CreateLink /etc/systemd/system/bluetooth.target.wants/bluetooth.service /usr/lib/systemd/system/bluetooth.service
CreateLink /etc/systemd/system/dbus-org.bluez.service /usr/lib/systemd/system/bluetooth.service
CreateLink /etc/systemd/system/multi-user.target.wants/tlp.service /usr/lib/systemd/system/tlp.service
CreateLink /etc/systemd/system/systemd-rfkill.service /dev/null
CreateLink /etc/systemd/system/systemd-rfkill.socket /dev/null
