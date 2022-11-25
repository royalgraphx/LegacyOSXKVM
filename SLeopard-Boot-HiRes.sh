#!/bin/bash

qemu-system-x86_64 -machine pc-q35-6.1,vmport=off,accel=kvm -bios /usr/share/edk2-ovmf/x64/OVMF_CODE.fd \
-name "Snow Leopard" \
-uuid 3259DCE2-A537-47C1-B2C6-FFB44069788C \
-vga none \
-device vmware-svga \
-device virtio-rng-pci \
-device e1000,mac=EE:E9:D3:14:05:CF,netdev=net0 \
-netdev user,id=net0 \
-cpu Penryn,vendor=GenuineIntel,+sse4.1,+sse4.2,+ssse3 \
-smp 8,cores=4 \
-device isa-applesmc,osk="ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc" \
-m 16G \
-device ich9-intel-hda \
-device hda-duplex \
-usb \
-device usb-tablet,bus=usb-bus.0 \
-device usb-mouse,bus=usb-bus.0 \
-device usb-kbd,bus=usb-bus.0 \
-device ide-hd,bus=ide.0,drive=OpenCore,bootindex=0 \
-drive "if=none,format=raw,media=disk,id=OpenCore,file=opencore/1920x1080-OpenCoreSLeopard.img,discard=unmap,detect-zeroes=unmap" \
-device ide-hd,bus=ide.2,drive=HardDrives,bootindex=2 \
-drive "if=none,format=raw,media=disk,id=HardDrives,file=harddrives/macintosh.img,discard=unmap,detect-zeroes=unmap" \
