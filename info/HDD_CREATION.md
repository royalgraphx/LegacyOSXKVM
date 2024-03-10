<h3 align="center">How to: Creating Macintosh SSD for installation</h3>

```bash
qemu-img create -f raw harddrives/macintosh.img 128G
```
<h5 align="center">Warning! This expects you to have 128GB free storage!</h5>

<p align="center">Create a virtual HDD image where Mac OS X will be installed. If you change the name of the disk image from `macintosh.img` to something else, the boot scripts will need to be updated to point to the new image name. Feel free to replace 128G with your desired disk size.</p>
