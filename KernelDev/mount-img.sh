IMG=$1
DIR=mount-point.tmp

mkdir $DIR

# 以 loop mount 方式挂载，img 中包含了文件系统
sudo mount -o loop $IMG $DIR
