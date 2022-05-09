- mk-qemu-rootfs : 为 qemu 构建一个 rootfs，打包成 ext2 img 格式。 qemu 启动时可通过 `-hda` 使用。

```bash

./mk-qemu-img.sh qemu-img-5G 5G
./mount-img.sh qemu-img-5G 

# ...

./umount-img.sh 
```