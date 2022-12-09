#!/bin/bash

qemu-system-ppc -L pc-bios \
-name "Mac OS X Cheetah" \
-uuid 3159DCE2-A537-47C1-B2C6-FFB44069788C \
-smp 1,cores=1 \
-boot d \
-M mac99 \
-m 2048 \
-device ide-cd,bus=ide.0,drive=OSXInstaller \
-drive "if=none,format=raw,media=disk,id=OSXInstaller,file=osxinstaller/MacOSX10.0.3.iso,discard=unmap,detect-zeroes=unmap" \
-device ide-hd,bus=ide.1,drive=HardDrives \
-drive "if=none,format=raw,media=disk,id=HardDrives,file=harddrives/cheetah.img,discard=unmap,detect-zeroes=unmap,detect-zeroes=unmap" \
