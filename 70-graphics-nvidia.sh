# packages
AddPackage nvidia-dkms   # NVIDIA kernel modules - module sources
AddPackage nvidia-prime  # NVIDIA Prime Render Offload configuration and utilities
AddPackage opencl-nvidia # OpenCL implemention for NVIDIA

# mkinitcpio - enable nvidia modules
cat >"$(CreateFile /etc/mkinitcpio.conf.d/00-modules_intel_nvidia_hybrid.conf)" <<EOF
MODULES=(i915 nvidia nvidia_modeset nvidia_uvm nvidia_drm)
EOF

# modprobe - configure nvidia
cat >"$(CreateFile /etc/modprobe.d/nvidia.conf)" <<EOF
options nvidia-drm modeset=1 nvidia-drm fbdev=1
options nvidia "NVreg_DynamicPowerManagement=0x02"
options nvidia NVreg_UsePageAttributeTable=1 NVreg_InitializeSystemMemoryAllocations=0 NVreg_EnableGpuFirmware=0
EOF

# add udev rules, so nvidia GPU could enter D3Cold state, when not in use and the laptop is on battery
cat >"$(CreateFile /etc/udev/rules.d/80-nvidia.rules)" <<EOF
# Enable runtime PM for NVIDIA VGA/3D controller devices on driver bind
ACTION=="bind", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030000", TEST=="power/control", ATTR{power/control}="auto"
ACTION=="bind", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030200", TEST=="power/control", ATTR{power/control}="auto"

# Disable runtime PM for NVIDIA VGA/3D controller devices on driver unbind
ACTION=="unbind", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030000", TEST=="power/control", ATTR{power/control}="on"
ACTION=="unbind", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030200", TEST=="power/control", ATTR{power/control}="on"

# Enable runtime PM for NVIDIA VGA/3D controller devices on adding device
ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030000", TEST=="power/control", ATTR{power/control}="auto"
ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030200", TEST=="power/control", ATTR{power/control}="auto"
EOF

# systemd enable
CreateLink /etc/systemd/system/multi-user.target.wants/nvidia-persistenced.service /usr/lib/systemd/system/nvidia-persistenced.service
CreateLink /etc/systemd/system/systemd-suspend.service.wants/nvidia-resume.service /usr/lib/systemd/system/nvidia-resume.service
CreateLink /etc/systemd/system/systemd-suspend.service.wants/nvidia-suspend.service /usr/lib/systemd/system/nvidia-suspend.service
CreateLink /etc/systemd/system/nvidia-powerd.service /dev/null
CreateLink /etc/systemd/system/systemd-hibernate.service.wants/nvidia-hibernate.service /usr/lib/systemd/system/nvidia-hibernate.service
CreateLink /etc/systemd/system/systemd-hibernate.service.wants/nvidia-resume.service /usr/lib/systemd/system/nvidia-resume.service
