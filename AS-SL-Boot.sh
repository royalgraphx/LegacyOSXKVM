#!/bin/bash
#
# Copyright (c) 2024 RoyalGraphX.
# GNU General Public License v3.0
#

clear

qemu-system-x86_64 -machine pc-q35-5.1,vmport=off -bios ./ovmf/OVMF_CODE.fd \
-name "Snow Leopard on Apple Silicon" \
-uuid 3B96F0FA-7384-4082-A1CD-55AA7E657790 \
-vga none \
-device vmware-svga \
-device virtio-rng-pci \
-device e1000,mac=EE:E9:D3:14:05:CF,netdev=net0 \
-netdev user,id=net0 \
-cpu Penryn,vendor=GenuineIntel,+sse4.1,+sse4.2,+ssse3 \
-smp 8,cores=4,threads=2 \
-device isa-applesmc,osk="ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc" \
-m 6G \
-device intel-hda -device hda-output \
-usb \
-device usb-tablet,bus=usb-bus.0 \
-device usb-mouse,bus=usb-bus.0 \
-device usb-kbd,bus=usb-bus.0 \
-device ide-hd,bus=ide.0,drive=OpenCore,bootindex=0 \
-drive "if=none,format=raw,media=disk,id=OpenCore,file=opencore/AS_SL.img,discard=unmap,detect-zeroes=unmap" \
-device ide-hd,bus=ide.1,drive=HardDrives,bootindex=1 \
-drive "if=none,format=raw,media=disk,id=HardDrives,file=harddrives/macintosh.img,discard=unmap,detect-zeroes=unmap" \