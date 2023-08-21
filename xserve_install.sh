#!/bin/bash
#
# Copyright (c) 2023 RoyalGraphX.
# GNU General Public License v3.0
#

clear

qemu-system-x86_64 -machine pc-q35-6.1,vmport=off -bios ./ovmf/OVMF_CODE.fd \
-name "Xserve" \
-uuid B671CF80-3FB2-11EE-84FF-D14F3CD62A88 \
-vga none \
-device vmware-svga \
-device virtio-rng-pci \
-device e1000,mac=EE:E9:D3:14:05:CF,netdev=net0 \
-netdev user,id=net0 \
-cpu Westmere,vendor=GenuineIntel \
-smp 8,cores=4,threads=2 \
-device isa-applesmc,osk="ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc" \
-m 16G \
-device intel-hda -device hda-output \
-usb \
-device usb-tablet,bus=usb-bus.0 \
-device usb-mouse,bus=usb-bus.0 \
-device usb-kbd,bus=usb-bus.0 \
-device ide-hd,bus=ide.0,drive=OpenCore,bootindex=0 \
-drive "if=none,media=disk,id=OpenCore,file=opencore/LegacyDarwinKVM.qcow2,discard=unmap,detect-zeroes=unmap" \
-device ide-hd,bus=ide.1,drive=HardDrives,bootindex=1 \
-drive "if=none,format=raw,media=disk,id=HardDrives,file=harddrives/macintosh.img,discard=unmap,detect-zeroes=unmap" \
-device ide-hd,bus=ide.2,drive=OSXInstaller,bootindex=2 \
-drive "if=none,format=raw,media=disk,id=OSXInstaller,file=osxinstaller/osxserver.img,discard=unmap,detect-zeroes=unmap" \