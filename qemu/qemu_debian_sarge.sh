# QEMU_TMPDIR is the ramdisk used for accelerating qemu
# this version is for running headless
# make sure you add 'console=ttyS0,9600' to your grub, and start a getty on
# ttyS0
PIDFILE=/local/mnt/virtual/debian-sarge/debian-sarge.pid

QEMU_TMPDIR=/local/mnt/virtual/ramdisk /usr/local/bin/qemu \
    -cdrom /local/mnt/ISOs/debian-31r2-i386-netinst.iso \
    -pidfile $PIDFILE -monitor stdio \
    -boot c -localtime \
	-redir tcp:22222::22 -redir tcp:9000::9000 \
	-redir tcp:24000::24000 -redir tcp:24001::24001 -redir tcp:24002::24002 \
	-redir tcp:24003::24003 -redir tcp:24004::24004 \
	-usb -usbdevice disk:demo0.qcow -usbdevice disk:demo1.qcow \
	-usbdevice disk:demo2.qcow -usbdevice disk:demo3.qcow \
	-usbdevice disk:demo4.qcow -usbdevice disk:demo5.qcow \
	-hda disk1.qcow -hdb disk2.qcow

# you can't use this if you background qemu, as the PID file will be removed
# as soon as the shell returns from backgrounding the qemu process
if [ $? -gt 0 ]; then 
   echo "QEMU exited with status code of $?"
fi
#rm $PIDFILE

#    -boot c -localtime -redir tcp:2222::22 disk1.img
# -boot 
# a == floppy
# c == hard drive
# d == cd rom
#    -monitor stdio -serial stdio \

# this version is for when you want a display
# CWD=$(pwd)

# $CWD/bin/qemu \
#    -cdrom $CWD/isos/debian-31r1a-i386-netinst.iso \
#    -pidfile $CWD/pids/$PIDFILE \
#    -boot c -localtime -redir tcp:2222::22 \
#	 $CWD/disks/debian.sarge.qcow
# make sure you add 'console=ttyS0,9600 console=tty0' to your grub, and start a
# getty on ttyS0
