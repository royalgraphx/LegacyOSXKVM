#!/bin/bash

qemu-system-ppc -accel tcg,tb-size=2048 \
-name "Mac OS X Snow Leopard [PPC Mode]" \
-machine mac99,via=pmu \
-cpu G4 \
-m 2048 \
-netdev user,id=qemunet0 \
-device e1000,netdev=qemunet0 \
-g 1440x900x32 \
-device VGA,edid=on,vgamem_mb=64,xres=1440,yres=900 \
-monitor stdio \
-boot d \
-hda "harddrives/macintosh.img" \
-cdrom "osxinstaller/10.6_snowleopard_DP_10A96_clientdvd.iso"