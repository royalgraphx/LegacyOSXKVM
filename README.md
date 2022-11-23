### A Template QEMU/KVM for x86_64 Hosts for 'Legacy' Mac OS X (PPC/Intel) Guests.

This `README.md` documents the process of creating a `Virtual Hackintosh` system.
For converting PKG's & DMG's -> IMG -> QCOW2, follow `CONVERSIONS.md` for documentation.
For modifying Display Resolution, follow `OPENCORE.md` for documentation.

## Current Support Table

| Mac OS X | Status | Architecture | Boot Script | Installer | Notes |
| --- | --- | --- | --- | --- | --- |
| Version 10.0 : "Cheetah" | Boots, installs, runs | PowerPC | ./Cheeta-Boot.sh | [Download](https://dl.bobpony.com/macos/cheetah/Mac%20OS%20X%2010.0.3.7z)
| Version 10.1 : "Puma" | Boots, installs, runs | PowerPC | ./Puma-Boot.sh | [Download](https://dl-lt1.winworldpc.com/Abandonware%20Operating%20Systems/Macintosh/Apple%20Mac%20OS%20X%2010.1%20(''Puma''%2010.1.5G64).7z)
| Version 10.2: "Jaguar" | Boots, installs, runs | PowerPC | ./Jaguar-Boot.sh | [Download](https://dl.bobpony.com/macos/jaguar/Apple%20Mac%20OS%20X%2010.2%20%2810.2.6C115%29.7z) | Disk 1 & 2 Needed |
| Version 10.3: "Panther" | Boots, installs, runs | PowerPC | ./Panther-Boot.sh | [Disk 1](https://dl-alt1.winworldpc.com/Apple%20Mac%20OS%20X%2010.3.0%20-%20Disk%201.7z) & [Disk 2](https://dl-alt1.winworldpc.com/Apple%20Mac%20OS%20X%2010.3.0%20-%20Disk%202.7z)| Disk 1 & 2 Needed |
| Version 10.4: "Tiger" | Boots, installs, runs | PowerPC | ./Tiger-Boot.sh | [Download](https://drive.google.com/file/d/16IHD6UjQUSfAudv8UrICOMudaVSeOorV/view)
| Version 10.5: "Leopard" | Boots, installs, runs | PowerPC / Intel | ./Leopard-PPC-Boot.sh & ./Leopard-Intel-Boot.sh | [Download PPC](https://macintoshgarden.org/apps/mac-osx-mac-os-10-ppc?page=1) & [Download Intel](https://archive.org/details/OsxLeopardInstall)
| Version 10.6: "Snow Leopard" | Boots, installs, runs | PowerPC (?) / Intel | ./SLeopard-Boot.sh | [Download]() | OOB Support, Inspired this |
| Version 10.7: "Lion" | Untested | Intel  | ./Lion-Boot.sh | [Download](https://archive.org/details/install-mac-os-x-lion-10.7.0-lion) | Needs Prev Install of Snow Leopard |
| Version 10.8: "Mountain Lion" | Untested | Intel | ./MLion-Boot.sh | [Download](https://archive.org/details/osxmountainlion1085) | Needs Prev Install of Snow Leopard |
| Version 10.9: "Mavericks" | Untested | Intel | ./Mavericks-Boot.sh | [Download](https://archive.org/details/OSXMavericksInstallDVD) | Follow this guide to convert dmgs -> img -> qcow2 |
| Version 10.10: "Yosemite" | Untested | Intel | ./Yosemite-Boot.sh | [Download](http://swcdn.apple.com/content/downloads/21/09/031-20634/8d84o1ky5gn2agnf5kiz9eed134n7y3q4c/RecoveryHDUpdate.pkg)
| Version 10.11: "El Capitan" | Untested | Intel | ./Capitan-Boot.sh | [Download](http://swcdn.apple.com/content/downloads/08/58/031-45768/yy0xr85ltis3a7mxuqf3zgaw7sovupckd7/RecoveryHDUpdate.pkg)
| Version 10.12: "Sierra" | Untested | Intel | ./Sierra-Boot.sh | [Download](http://swcdn.apple.com/content/downloads/01/53/031-86778/pnekzincp6rkf5iu91onj1bm5mw1gotnwg/RecoveryHDUpdate.pkg)

###### For anything Mac OS X 10.13 High Sierra and above, please refer to [Kholia OSX-KVM](https://github.com/kholia/OSX-KVM/)

### Is This Legal?

The "secret" Apple OSK string is widely available on the Internet. It is also included in a public court document [available here](http://www.rcfp.org/sites/default/files/docs/20120105_202426_apple_sealing.pdf). I am not a lawyer but it seems that Apple's attempt(s) to get the OSK string treated as a trade secret did not work out. Due to these reasons, the OSK string is freely included in this repository, as per Kholia OSX-KVM.

### Requirements

* A modern Linux distribution. E.g. Ubuntu 22.04 LTS 64-bit or later.

* QEMU >= 6.2.0

* A CPU with Intel VT-x / AMD SVM support is required (`grep -e vmx -e svm /proc/cpuinfo`)

* A CPU with SSE4.1 support is required for Mac OS X Sierra

Note: Older AMD CPU(s) are known to be problematic. AMD FX-8350 works but
Phenom II X3 720 does not. Ryzen processors work just fine.

### Create Macintosh SSD for installation

Create a virtual HDD image where Mac OS X will be installed. If you change the
  name of the disk image from `macintosh.img` to something else, the boot scripts
  will need to be updated to point to the new image name.

  ```
  qemu-img create -f qcow2 harddrives/macintosh.img 128G
  ```

  NOTE: Create this image file on a fast SSD/NVMe disk for best results.

### Installation

For this guide, as this was initially created for Mac OS X Snow Leopard, we'll be going through the steps for that.
OpenCore though, is really the shining star here. These Boot and Install scripts simply define a machine that matches
as closely as possible to the hardware found in the systems at their time period. Thus, as long as you more or less
follow this guide, you should be able to install the majority of Mac OS X, and for more recent versions, OSX-KVM exists.

##### Explaining the Directory Structure

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

```
osxinstaller/

Use this directory to store your installer images, in this example i'm using my fixed snow leopard qcow2
```
```
opencore/

this directory stores the OpenCore bootloader! you can customize it, manage it, add more, and quickly swap to working opencores for other OS X installs!
```
```
harddrives/

Use this directory to store your Macintosh SSD and use to manage multiple installs!
```
```
cdrom/

This directory is used to mount iso's to the CD-ROM in Mac OS X, use for installing apps, and moving files to the VM!
```
