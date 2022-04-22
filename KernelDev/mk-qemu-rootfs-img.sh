IMG=$1
DIR=mount_point.tmp

# qemu-img create img file 
qemu-img create $IMG 1g
# format image
mkfs.ext2 $IMG

mkdir $DIR
# 以 loop mount 方式挂载，img 中包含了文件系统
sudo mount -o loop $IMG $DIR
# debootstrap get ubuntu package
sudo debootstrap --arch=amd64  bionic  $DIR  http://mirrors.aliyun.com/ubuntu/ 

sudo umount $DIR
rmdir $DIR