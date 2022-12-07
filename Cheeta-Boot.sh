#!/bin/bash

qemu-system-ppc -L pc-bios \
-name "Mac OS X Cheetah" \
-uuid 3159DCE2-A537-47C1-B2C6-FFB44069788C \
-smp 1,cores=1 \
-boot c \
-M mac99 \
-m 2048 \
-device ide-hd,bus=ide.1,drive=HardDrives \
-drive "if=none,format=raw,media=disk,id=HardDrives,file=harddrives/macintosh.img,discard=unmap,detect-zeroes=unmap,detect-zeroes=unmap" \