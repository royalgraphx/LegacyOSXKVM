### Explaining the Repository Structure

```bash
.
├── cdrom
│   └── 1920x1080-OpenCore.img
├── harddrives
│   └── macintosh.img
├── opencore
│   └── opencore.qcow2
├── osxinstaller
│   └── sl_utm.qcow2
└── SLeopard-Boot.sh
```

##### osxinstaller/

###### Use this directory to store your installer images, in this example i'm using my fixed snow leopard qcow2

##### opencore/

###### this directory stores the OpenCore bootloader! you can customize it, manage it, add more, and quickly swap to working opencores for other OS X installs!

##### harddrives/

###### Use this directory to store your Macintosh SSD and use to manage multiple installs!

##### cdrom/

###### This directory is used to mount iso's to the CD-ROM in Mac OS X, use for installing apps, and moving files to the VM!

### Explaining the Install/Boot Scripts

```bash
qemu-system-x86_64 -machine pc-q35-6.1,vmport=off,accel=kvm -bios /usr/share/edk2-ovmf/x64/OVMF_CODE.fd \

# Defines QEMU Window Name & Device UUID
-name "Snow Leopard" \
-uuid 3159DCE2-A537-47C1-B2C6-FFB44069788C \

# Defines Graphics
-vga none \
-device vmware-svga \

# Defines Ethernet
-device e1000,mac=8A:A8:6A:F8:00:51,netdev=net0 \
-netdev user,id=net0 \

# Defines CPU
-cpu Penryn,vendor=GenuineIntel,+sse4.1,+sse4.2,+ssse3 \
-smp 4,cores=2 \

# Amount of RAM
-m 4G \

# Manage Drives and Disks, if mounting img, please specify "format=raw" after 'if'

-device ide-hd,bus=ide.0,drive=OpenCore,bootindex=0 \
-drive "if=none,media=disk,id=OpenCore,file=opencore/opencore.qcow2,discard=unmap,detect-zeroes=unmap" \

-device ide-hd,bus=ide.1,drive=OSXInstaller,bootindex=1 \
-drive "if=none,media=disk,id=OSXInstaller,file=osxinstaller/sl_utm.qcow2,discard=unmap,detect-zeroes=unmap" \

-device ide-hd,bus=ide.2,drive=HardDrives,bootindex=2 \
-drive "if=none,format=raw,media=disk,id=HardDrives,file=harddrives/Macintosh.img,discard=unmap,detect-zeroes=unmap" \

-device ide-hd,bus=ide.3,drive=CDROM,bootindex=3 \
-drive "if=none,format=raw,media=disk,id=CDROM,file=cdrom/1920x1080-OpenCore.img,discard=unmap,detect-zeroes=unmap" \
```
##### The presence of the OSXInstaller drive is present dependent on if using Install or Boot script. Feel free to edit the CPU cores, and RAM accordingly.

### Explaining the OpenCore config

I followed this neat guide on [Adam Roe's](https://adamroe.me/blog/snow-leopard-utm.php) blog, detailing how to run Snow Leopard on a Mac, running UTM! which is just a frontend GUI for MacOS that uses QEMU under the hood. Sadly in my attempts to do it fully on linux, there were no regular guides (even on YouTube) on running Mac OS X Snow Leopard *specifically* on QEMU/KVM on Linux hosts. I ran into multiple issues including not knowing how to define the CPU specifically as detailed, and when I was finally able to boot into OpenCore, and load the Installer... "Still waiting for root device" was obviously a tell that I wasn't mounting the images correcty. I sadly ended up having to use my real Macbook Air to run UTM and follow the guide, copying the converted OS X Snow Leopard Installer in qcow2 format, and when exporting the command to launch the UTM VM, I was able to correctly define the disks to QEMU and finally resulting in a working boot! The OpenCore image is taken directly from Adam Roe and all the credit goes to him for getting all the necessary files needed to boot on QEMU TianoCore. AFAIK modification is okay, so if need be, edit to suite the needs of other Mac OS X versions.
