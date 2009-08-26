# QEMU_TMPDIR is the ramdisk used for accelerating qemu
# this version is for running headless
# make sure you add 'console=ttyS0,9600' to your grub, and start a getty on
# ttyS0
PIDFILE=/local/mnt/virtual/naranja_test/qemu.pid

# if you get errors when starting QEMU about 'kqemu' not being found, re-insert
# the kqemu kernel module: /sbin/modprobe kqemu major=250
# also make sure that /dev/kqemu is writeable by the same user that's running
# qemu

QEMU_TMPDIR=/local/mnt/virtual/ramdisk /usr/local/bin/qemu \
    -cdrom /local/mnt/www/ISOs/debian-40r0-i386-CD-1.iso \
    -pidfile $PIDFILE \
    -monitor stdio \
    -kernel-kqemu \
    -localtime \
    -m 192 \
    -boot n \
    -tftp /local/mnt/virtual/naranja_test \
    -bootp /pxelinux.0 \
	-redir tcp:2200::22 \
	-redir tcp:24443::24443 \
	-redir tcp:27448::27448 \
	-usb \
    -usbdevice tablet \
	-hda disk1.qcow2 
    #-hdb disk2.qcow

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
