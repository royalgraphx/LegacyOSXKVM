### A Guide on converting DMG's to usable Legacy OS X QEMU Guest qcow2's

##### Credits to Adam Roe for the write-up! Check out his original post [here](https://adamroe.me/blog/snow-leopard-utm.php)

You’ll need qemu-img, which is provided by QEMU. 

`$ brew install qemu`

### Source a disk image

Mount the disk image:

```
$ hdiutil mount /tmp/10.6.7-10J4139-ACDT-OSX.dmg
Checksumming весь диск (Apple_HFS : 0)...
...............................................................................
           весь диск (Apple_HFS : 0): verified   CRC32 $39AD4D29
verified   CRC32 $7AA20F20
/dev/disk4                                              /Volumes/Mac OS X Install DVD
```

This will mount the disk image to /Volumes/Mac OS X Install DVD

### Use asr to restore disk image to a new disk image

First lets create an empty image with a size rounded up enough to fit the other.

```
$ hdiutil create -size 10G -fs HFS+ -volname utm_installer /tmp/sl_utm.dmg
created: /tmp/sl_utm.dmg
```

… and mount it:

```
$ hdiutil mount /tmp/sl_utm.dmg
/dev/disk5              GUID_partition_scheme           
/dev/disk5s1            EFI                             
/dev/disk5s2            Apple_HFS                       /Volumes/utm_installer
```

… which mounts the blank disk image to /Volumes/utm_installer

Then, use Apple System Restore to write the installer to the read-write disk image:

```
$ sudo asr restore \
-source /Volumes/Mac\ OS\ X\ Install\ DVD \
-target /Volumes/utm_installer \
-erase -noverify
```

Enter y when prompted

```
Validating target...done
        Validating source...done
        Erase contents of /dev/disk5s2 (/Volumes/utm_installer)? [ny]: y
        Validating sizes...done
        Restoring  ....10....20....30....40....50....60....70....80....90....100
        Restored target device is /dev/disk5s2.
        Remounting target volume...done
 Restore completed successfully.
```

Eject all the disk images:

```
$ hdiutil eject /Volumes/Mac\ OS\ X\ Install\ DVD
"disk4" ejected.

$ hdiutil eject /Volumes/Mac\ OS\ X\ Install\ DVD\ 1
"disk5" ejected.
```

### Convert new disk image to cdr master

Now, we need to convert the disk image to a CDR master:

```
$ hdiutil convert /tmp/sl_utm.dmg -format UDTO -o /tmp/sl_utm.cdr
Reading Protective Master Boot Record (MBR : 0)...
Reading GPT Header (Primary GPT Header : 1)...
Reading GPT Partition Data (Primary GPT Table : 2)...
Reading  (Apple_Free : 3)...
Reading EFI System Partition (C12A7328-F81F-11D2-BA4B-00A0C93EC93B : 4)...
..
Reading disk image (Apple_HFS : 5)...
.........................................................................................................................
Reading  (Apple_Free : 6)...
Reading GPT Partition Data (Backup GPT Table : 7)...
.........................................................................................................................
Reading GPT Header (Backup GPT Header : 8)...
.........................................................................................................................
Elapsed Time: 54.014s
Speed: 189.6MB/s
Savings: 0.0%
created: /tmp/sl_utm.cdr
```

### Convert cdr master to raw disk image

Finally, we need to convert the ISO into something that can be mounted by QEMU

```
$ qemu-img convert -p /tmp/sl_utm.cdr -O raw sl_utm.img
    (100.00/100%)
```

### Converting to qcow2

```
$ qemu-img convert -f raw -O qcow2 sl_utm.img sl_utm.qcow2
```

# This requires using a Mac (for best results... I couldn't do dmg2img on Linux and then convert that to qcow2, I'd get "Still waiting on root device") ! You can get away with doing it in a VM, which is what I recommend.