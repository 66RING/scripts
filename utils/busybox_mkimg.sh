#!/bin/sh
# busybox编译出最小文件系统后还有进行一些操作将其补完成一个完整文件系统
#
# 每条命令都给我注释好

###
### 放在 _install 文件夹中
###

#
# 制作文件系统
#
rm -rf etc dev proc sys tmp mnt

mkdir -p etc dev proc sys tmp mnt
mkdir -p etc/init.d/ ##

echo -e "proc  /proc proc  defaults 0 0
tmpfs /tmp  tmpfs defaults 0 0
sysfs /sys  sysfs defaults 0 0
tmpfs /dev  tmpfs defaults 0 0
" > etc/fstab

echo -e "#!/bin/sh
echo -e \"Halo\"
mount -a
# mount -o remount,rw
mkdir -p /dev/pts
mount -t devpts devpts /dev/pts
echo /sbin/mdev > /proc/sys/kernel/hotplug
mdev -s
" > etc/init.d/rcS

chmod 755 etc/init.d/rcS

echo -e "::sysinit:/etc/init.d/rcS
::respawn:-/bin/sh
::askfirst:-/bin/sh
::ctrlaltdel:/bin/umount -a -r
" > etc/inittab

chmod 755 etc/inittab
mknod dev/console c 5 1
mknod dev/null c 1 3
mknod dev/tty1 c 4 1


rm -rf rootfs_tmp.img
rm -rf rootfs_tmp.img.gz
rm -rf initrd.cpio.gz


#
# 制作镜像
#
dd if=/dev/zero of=./rootfs_tmp.img bs=1M count=16
mkfs.ext2 rootfs_tmp.img
mkdir fs
mount -o loop rootfs_tmp.img ./fs
cp -rf $(ls | grep -v fs) ./fs
umount ./fs
gzip --best -c rootfs_tmp.img > rootfs_tmp.img.gz
rm -rf fs


#
# 制作initrd
#
find . -print0 | cpio --null -ov --format=newc | gzip -9 > initrd.cpio.gz
